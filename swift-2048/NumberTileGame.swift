//
//  NumberTileGame.swift
//  swift-2048
//
//  Created by Austin Zheng on 6/3/14.
//  Copyright (c) 2014 Austin Zheng. Released under the terms of the MIT license.
//

import UIKit

let vcWidth: CGFloat = UIScreen.main.bounds.size.width  // 画面の横の大きさを取得
let vcHeight: CGFloat = UIScreen.main.bounds.size.height    // 画面の縦の大きさを取得
let myDefaultHP = 1000    // 自分の初期のHP
var myHP = myDefaultHP  // 自分の現在のHP
var arrayMonster: [UIImageView] = []

/// A view controller representing the swift-2048 game. It serves mostly to tie a GameModel and a GameboardView
/// together. Data flow works as follows: user input reaches the view controller and is forwarded to the model. Move
/// orders calculated by the model are returned to the view controller and forwarded to the gameboard view, which
/// performs any animations to update its state.
class NumberTileGameViewController : UIViewController, GameModelProtocol {

    var dimension: Int   // ゲームボードの行列数
    var threshold: Int   // ゲーム勝利するタイル数字

    var board: GameboardView?
    var model: GameModel?

    var scoreView: ScoreViewProtocol?

    // ゲームボードの幅
    let boardWidth: CGFloat = 300.0
    // タイルの間の空白
    let thinPadding: CGFloat = 3.0
    let thickPadding: CGFloat = 6.0

    // ゲームボードとスコアビュー等の間のスペース
    let viewPadding: CGFloat = vcHeight * 9 / 20

    // Amount that the vertical alignment of the component views should differ from if they were centered
    let verticalViewOffset: CGFloat = 0.0

    let recoveryButton = UIButton()    // HP回復ボタン
    let recoveryAmount = 10 // 回復量

    var countEnemy = 0
    var arrayEnemy: [UIImageView] = []
    var countMonster = 0
    
    var damage = enemyParty[0].attack  // 敵の攻撃により受けるダメージ

  //dimensionとthreshould
  init(dimension d: Int, threshold t: Int) {
    dimension = d > 2 ? d : 2
    threshold = t > 8 ? t : 8
    super.init(nibName: nil, bundle: nil)
    model = GameModel(dimension: dimension, threshold: threshold, delegate: self)
    view.backgroundColor = UIColor.black      //ゲーム画面全体の背景色
    setupSwipeControls()
  }

  required init(coder aDecoder: NSCoder) {
    fatalError("NSCoding not supported")
  }

  //スワイプ操作
  func setupSwipeControls() {
    //上スワイプ
    let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(NumberTileGameViewController.upCommand(_:)))
    upSwipe.numberOfTouchesRequired = 1
    upSwipe.direction = UISwipeGestureRecognizerDirection.up
    view.addGestureRecognizer(upSwipe)

    //下スワイプ
    let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(NumberTileGameViewController.downCommand(_:)))
    downSwipe.numberOfTouchesRequired = 1
    downSwipe.direction = UISwipeGestureRecognizerDirection.down
    view.addGestureRecognizer(downSwipe)

    //左スワイプ
    let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(NumberTileGameViewController.leftCommand(_:)))
    leftSwipe.numberOfTouchesRequired = 1
    leftSwipe.direction = UISwipeGestureRecognizerDirection.left
    view.addGestureRecognizer(leftSwipe)

    //右スワイプ
    let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(NumberTileGameViewController.rightCommand(_:)))
    rightSwipe.numberOfTouchesRequired = 1
    rightSwipe.direction = UISwipeGestureRecognizerDirection.right
    view.addGestureRecognizer(rightSwipe)
  }


  // View Controller
  override func viewDidLoad()  {    //画面表示後の処理
    super.viewDidLoad()
    setupGame()     //ゲームセットアップ処理を外出し
  }

  //ゲームリセット
    func resetGame(defaultHP: Int) {
    assert(board != nil && model != nil)
  //  let b = board!
    let m = model!
    //b.resetBoard()
    m.resetState(defaultHP: defaultHP)
    m.insertTileAtRandomLocation(withValue: 2)
    m.insertTileAtRandomLocation(withValue: 2)
  }

    //ゲームのセットアップ
    func setupGame() {
        // 戦闘背景画像を設定
        let imageViewBattleBackground = UIImageView(frame: CGRect(x: 0, y: (vcHeight - vcWidth) /  6, width: vcWidth, height: vcWidth)) // 背景画像の大きさを設定
        imageViewBattleBackground.image = UIImage(named: "bg_natural_ocean.jpg") // 画像を設定
        self.view.addSubview(imageViewBattleBackground) // 背景画像を追加する
//
//        // ゲームボード背景画像を設定
        let imageViewGameBoardBackground = UIImageView(frame: CGRect(x: 0, y: (vcHeight - vcWidth) /  6 + vcWidth, width: vcWidth, height: vcWidth * 0.83)) // 背景画像の大きさを設定
        imageViewGameBoardBackground.image = UIImage(named: "bg_pattern_ishigaki.jpg") // 画像を設定
        self.view.addSubview(imageViewGameBoardBackground) // 背景画像を追加する
        
        //初期敵モンスター表示
        let firstEnemy = enemyImageView(enemyImageName: enemyParty[0].imageName)
        view.addSubview(firstEnemy)
        arrayEnemy.append(firstEnemy)
        
        // This nested function provides the x-position for a component view
        func xPositionToCenterView(_ v: UIView) -> CGFloat {
          let viewWidth = v.bounds.size.width
          let tentativeX = 0.5*(vcWidth - viewWidth)
          return tentativeX >= 0 ? tentativeX : 0
        }
        // This nested function provides the y-position for a component view
        func yPositionForViewAtPosition(_ order: Int, views: [UIView]) -> CGFloat {
          assert(views.count > 0)
          assert(order >= 0 && order < views.count)
        //      let viewHeight = views[order].bounds.size.height
          let totalHeight = CGFloat(views.count - 1)*viewPadding + views.map({ $0.bounds.size.height }).reduce(verticalViewOffset, { $0 + $1 })
          let viewsTop = 0.5*(vcHeight - totalHeight) >= 0 ? 0.5*(vcHeight - totalHeight) : 0

          // Not sure how to slice an array yet
          var acc: CGFloat = 0
          for i in 0..<order {
            acc += viewPadding + views[i].bounds.size.height
          }
          return viewsTop + acc
        }

        // スコアビューの作成
        let scoreView = ScoreView(backgroundColor: UIColor.black,
          textColor: UIColor.white,
          font: UIFont(name: "HelveticaNeue-Bold", size: 16.0) ?? UIFont.systemFont(ofSize: 16.0),
          radius: 6)
        scoreView.score = defaultHP
    
        myHPView(HP: myHP)   //自分のHPを表示

        // ゲームボードの作成
        let padding: CGFloat = dimension > 5 ? thinPadding : thickPadding
        let v1 = boardWidth - padding*(CGFloat(dimension + 1))
        let width: CGFloat = CGFloat(floorf(CFloat(v1)))/CGFloat(dimension)
        let gameboard = GameboardView(dimension: dimension,
          tileWidth: width,
          tilePadding: padding,
          cornerRadius: 6,
          backgroundColor: UIColor.black,
          foregroundColor: UIColor.darkGray)

        // フレームのセットアップ
        let views = [scoreView, gameboard]

        var f = scoreView.frame
        f.origin.x = xPositionToCenterView(scoreView)
        f.origin.y = yPositionForViewAtPosition(0, views: views)
        scoreView.frame = f

        f = gameboard.frame
        f.origin.x = xPositionToCenterView(gameboard)
        f.origin.y = yPositionForViewAtPosition(1, views: views)
        gameboard.frame = f


        // Add to game state
        view.addSubview(gameboard)
        board = gameboard
        view.addSubview(scoreView)
        self.scoreView = scoreView

        assert(model != nil)
        let m = model!
        m.insertTileAtRandomLocation(withValue: 2)
        m.insertTileAtRandomLocation(withValue: 2)
        
        //回復ボタン
        //let recoveryBottonWidth: CGFloat = 40
        recoveryButton.frame = CGRect(x:5, y:vcHeight * 0.6, width:40, height:40)           // 位置とサイズ
        recoveryButton.setTitle("♡", for:UIControl.State.normal)        // タイトル
        recoveryButton.titleLabel?.font =  UIFont.systemFont(ofSize: 30)        // フォントサイズ
        recoveryButton.backgroundColor = UIColor.systemPink        // 背景色
        recoveryButton.addTarget(self, action: #selector(NumberTileGameViewController.recoveryButtonTapped(sender:)), for: .touchUpInside)
        view.addSubview(recoveryButton)    // Viewにボタンを追加
        
    } // setupGame終わり
    
    //回復ボタンタップ処理
    @objc  func recoveryButtonTapped(sender : Any) {
        myHP += recoveryAmount
        if myHP >= myDefaultHP{
            myHP = myDefaultHP
        }
        myHPView(HP: myHP)   //自分のHPを表示
    }

  // スワイプした後の処理
    func followUp() {
        assert(model != nil)
        let m = model!
          // モンスターの表示と削除
        arrayMonster.append(monsterOfTileNum(tileNum: /*mergedTileNum*/ Int.random(in: 1..<11)))  // モンスター配列に1つ値を追加 tileNumは一時的にランダム
        if arrayMonster.count > 0{
            view.addSubview(arrayMonster[countMonster]) // 配列追加したモンスターの画像を表示する
        }
                    countMonster += 1
        if countMonster > 3 { // 同時に3体まで表示
            arrayMonster[Int.random(in: 0..<countMonster)].isHidden = true  // 表示されているモンスターの中からランダムで消す
        }
        
      
      // 確率で敵の攻撃を受ける
    //  if Int.random(in: 0..<3) == 0{    // 1/3の確率
          myHP -= self.damage     // ダメージ分自分のHPが減る
   //   }
        self.myHPView(HP: myHP)   //自分のHPを表示
        
        // 受けたダメージを一瞬表示する
        damageLabel(x: vcWidth*0.77, y: vcWidth * 1.15, text: "-\(damage)" )
        // 敵に与えたダメージを一瞬表示する
        damageLabel(x: vcWidth*0.25, y: 70, text: "-\(monsterParty[0].attack)")

      // 負けたときのアラート
      if m.userHasLost() {
        // TODO: alert delegate we lost
        NSLog("You lost...")
        let alertView = UIAlertView()
        alertView.title = "Defeat"
        alertView.message = "You lost..."
  //      alertView.addButton(withTitle: "OK")
        alertView.show()
      }
    
      // 勝ったとき
    let (userWon, _) = m.userHasWon()
    if userWon {
        // TODO: alert delegate we won
        arrayEnemy[countEnemy].isHidden = true  // 前の敵画像消去

        // ステージ途中の敵を倒したとき
        if countEnemy < enemyParty.count - 1{
            //次の敵出現、敵のステータス更新
            arrayEnemy.append(enemyImageView(enemyImageName: enemyParty[countEnemy+1].imageName))  // モンスター配列に1つ値を追加 次の敵の画像
            resetGame(defaultHP: enemyParty[countEnemy+1].HP)   // 次の敵のHP
            damage = enemyParty[countEnemy+1].attack   // 次の敵の攻撃力
            view.addSubview(arrayEnemy[countEnemy+1])     // 次の敵の画像表示
            countEnemy += 1  //countEnemy 1増やす
        }else{  //ステージ最後の敵を倒したとき
            let alertView = UIAlertView()   //アラート
            alertView.title = "Victory"
            alertView.message = "Stage Clear!"
            alertView.addButton(withTitle: "OK")
            alertView.show()
        }

      // TODO: At this point we should stall the game until the user taps 'New Game' (which hasn't been implemented yet)
      return
    }

    // 勝敗がつかない場合、タイルを追加して続行
    let randomVal = Int(arc4random_uniform(10))
    m.insertTileAtRandomLocation(withValue: randomVal == 1 ? 4 : 2)

  }
    
  // 上下左右コマンド
  @objc(up:)
  func upCommand(_ r: UIGestureRecognizer!) {
    assert(model != nil)
    let m = model!
    m.queueMove(direction: MoveDirection.up,
      onCompletion: { (changed: Bool) -> () in
        if changed {
            self.followUp()
        }
      })
  }

  @objc(down:)
  func downCommand(_ r: UIGestureRecognizer!) {
    assert(model != nil)
    let m = model!
    m.queueMove(direction: MoveDirection.down,
      onCompletion: { (changed: Bool) -> () in
        if changed {
            self.followUp()
        }
      })
  }

  @objc(left:)
  func leftCommand(_ r: UIGestureRecognizer!) {
    assert(model != nil)
    let m = model!
    m.queueMove(direction: MoveDirection.left,
      onCompletion: { (changed: Bool) -> () in
        if changed {
            self.followUp()
        }
      })
  }

  @objc(right:)
  func rightCommand(_ r: UIGestureRecognizer!) {
    assert(model != nil)
    let m = model!
    m.queueMove(direction: MoveDirection.right,
      onCompletion: { (changed: Bool) -> () in
        if changed {
            self.followUp()
        }
      })
  }
    
    // 敵画像を設定してImageViewを返す関数
    func enemyImageView(enemyImageName: String) -> UIImageView{
        let enemyImageView = UIImageView(frame: CGRect(x: vcWidth * 0.2, y: (vcHeight - vcWidth) * 0.2, width: vcWidth * 0.6, height: vcWidth * 0.6)) // 敵画像の位置と大きさを設定
        enemyImageView.image = UIImage(named: enemyImageName) // 画像を設定
        return enemyImageView // imageViewを返す
    }
        
    func damageLabel(x:CGFloat, y:CGFloat, text:String){
        let attackLabel = UILabel(frame: CGRect(x: x, y: y, width: 200, height: 30))
        attackLabel.font = UIFont.systemFont(ofSize: 20.0)
        attackLabel.text = text     // 表示する文字を代入する 要修正:
        attackLabel.textColor = UIColor.red      // 文字の色
        attackLabel.font = UIFont.systemFont(ofSize: 16.0)      // フォントの設定をする.
        attackLabel.textAlignment = NSTextAlignment.left     // 中央揃え
        attackLabel.layer.shadowOpacity = 200      // 影の濃さを設定する.
        view.addSubview(attackLabel)      // Viewに追加する
        // 少し経ったらダメージ表示を消す
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            attackLabel.isHidden = true
        }
    }
    
    // 自分のHP表示関数
    func myHPView(HP: Int){
        var label = UILabel(frame: CGRect(x: vcWidth/4, y: vcWidth * 1.15, width: vcWidth/2, height: vcWidth * 0.09))
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.text = "HP: \(HP) / \(myDefaultHP)"      // 表示する文字を代入する.
        label.textColor = UIColor.white      // 文字の色
        label.layer.masksToBounds = true      // 角に丸みをつける.
        label.layer.cornerRadius = 6.0      // 丸みのサイズを設定する.
        label.layer.borderWidth = 2      // 枠線の太さを設定する.
        label.layer.borderColor = UIColor.red.cgColor      // 枠線の色
        label.font = UIFont.systemFont(ofSize: 16.0)      // フォントの設定をする.
        label.textAlignment = NSTextAlignment.center      // 中央揃え
        //label.layer.shadowOpacity = 10      // 影の濃さを設定する.
        label.backgroundColor = UIColor.black      // 背景色
        //label.delegate = self   // Delegateを自身に設定する
        view.addSubview(label)      // Viewに追加する
    }

  // Protocol
  // スコア変化
  func scoreChanged(to score: Int) {
    if scoreView == nil {
      return
    }
    let s = scoreView!
    s.scoreChanged(to: score)
  }

  //1タイルの移動
  func moveOneTile(from: (Int, Int), to: (Int, Int), value: Int) {
    assert(board != nil)
    let b = board!
    b.moveOneTile(from: from, to: to, value: value)
  }
    
  //2タイルの移動
  func moveTwoTiles(from: ((Int, Int), (Int, Int)), to: (Int, Int), value: Int) {
    assert(board != nil)
    let b = board!
    b.moveTwoTiles(from: from, to: to, value: value)
  }

  //タイル挿入
  func insertTile(at location: (Int, Int), withValue value: Int) {
    assert(board != nil)
    let b = board!
    b.insertTile(at: location, value: value)
  }
}

// タイル数字に応じたモンスターのImageViewを返す
func monsterOfTileNum(tileNum: Int) -> UIImageView{
    let monsterSize = 30 + (tileNum - 1) * 12    // タイル数字に応じたモンスターの大きさ
    return  monsterImageView(imageName: monsterParty[tileNum - 1].imageName, monsterSize: monsterSize)    // モンスターのImageView
}

// 指定された画像ファイルとサイズでモンスターのImageViewを返す
func monsterImageView(imageName: String, monsterSize: Int) -> UIImageView{    // 引数：画像ファイル名, モンスターの大きさ 戻り値：imageView
    let interval = 20   // モンスター出現位置の間隔
    let monsterImageView = UIImageView(frame: CGRect(x: interval * Int.random(in: 1..<300 / interval) , y: interval * Int.random(in: 280 / interval..<400 / interval), width: monsterSize, height: monsterSize)) // モンスター出現位置と大きさを設定
    monsterImageView.image = UIImage(named: imageName) // 画像を設定
    return monsterImageView
}
