//
//  Home.swift
//  swift-2048
//
//  Created by YOSUKE on 2023/11/13.
//  Copyright © 2023 Austin Zheng. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let defaultX: CGFloat = 10
    let defaultY: CGFloat = 50
    var userName = "よすけ"  // ユーザー名
    var userLevel = 1       // ユーザーレベル
    var userJewel = 50      // ジュエル
    var userCoin = 1234     // コイン
    var userStamina = 80    // スタミナ
    let tabWidth: CGFloat = vcWidth / 6     // タブボタンのサイズ
    let monsterWidth: CGFloat = vcWidth * 0.9 / 5 // モンスター枠のサイズ
    let monsterPartyY: CGFloat = 130
    
    let eachMonsterWidth: CGFloat = 60
    let monsterBoxX: CGFloat = (vcWidth - 60 * 6) / 2
    let monsterBoxY: CGFloat = 280
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ユーザ情報表示
        userInfoLabel(x: defaultX, y: defaultY, width: vcWidth-defaultX*2, height: vcWidth * 0.09*2, text: "", textColor: .black, textAlignment: .left, bgColor: .black)    // 全体背景
        userInfoLabel(x: defaultX, y: defaultY, width: vcWidth/3, height: vcWidth * 0.09, text: userName, textColor: .black, textAlignment: .left, bgColor: .lightGray)    // ユーザー名
        userInfoLabel(x: defaultX+vcWidth/3, y: defaultY, width: vcWidth/3-defaultX*2, height: vcWidth * 0.09, text: "レベル:\(userLevel)", textColor: .black, textAlignment: .left, bgColor: .lightGray)    // ユーザーレベル
        userInfoLabel(x: defaultX, y: defaultY + vcWidth * 0.09, width: vcWidth/3, height: vcWidth * 0.09, text: "スタミナ:\(userStamina)", textColor: .black, textAlignment: .left, bgColor: .lightGray)    // ユーザースタミナ
        userInfoLabel(x: vcWidth - vcWidth/3 - defaultX, y: defaultY, width: vcWidth/3, height: vcWidth * 0.09, text: "ジュエル:\(userJewel)", textColor: .black, textAlignment: .right, bgColor: .lightGray)    // ジュエル
        userInfoLabel(x: vcWidth - vcWidth/3 - defaultX, y: defaultY + vcWidth * 0.09, width: vcWidth/3, height: vcWidth * 0.09, text: "コイン:\(userCoin)", textColor: .black, textAlignment: .right, bgColor: .lightGray)    // コイン
        
 
        // モンスターパーティの枠
        let monsterPartyLabel = UILabel(frame: CGRect(x: (vcWidth - vcWidth * 0.9)/2, y: monsterPartyY, width: vcWidth * 0.9, height: monsterWidth*2))
        monsterPartyLabel.layer.masksToBounds = true      // 角に丸みをつける.
        monsterPartyLabel.layer.cornerRadius = 6.0      // 丸みのサイズを設定する.
        monsterPartyLabel.layer.borderWidth = 2      // 枠線の太さを設定する.
        monsterPartyLabel.layer.borderColor = UIColor.black.cgColor      // 枠線の色
        monsterPartyLabel.font = UIFont.systemFont(ofSize: 16.0)      // フォントの設定をする.
        monsterPartyLabel.backgroundColor = UIColor.gray      // 背景色
        view.addSubview(monsterPartyLabel)      // Viewに追加する

//        // モンスターパーティボタン
//        for i in 0..<2 {    //2行
//            for j in 0..<5 {    //1行に5体表示
//                monsterPartyButton(x: (vcWidth - vcWidth * 0.9)/2 + monsterWidth * CGFloat(j), y: monsterPartyY + CGFloat(i) * monsterWidth, imageName: monsterParty[j+i*5].imageName, text: "\(j+i*5+1)", tileNum: i)
//            }
//        }
//        
//        // モンスターボックス
//        for i in 0..<7 {    //縦 7個
//            for j in 0..<6 {    // 横6個
//                eachMonsterButton(x:monsterBoxX + CGFloat(j) * eachMonsterWidth, y:monsterBoxY + CGFloat(i) * eachMonsterWidth, imageName:monsterBox[Int.random(in: 0..<monsterBox.count)].imageName)
//            }
//        }
//        
        // タブボタン
        tabBotton(x: defaultX,imageName: "syounyudou.png", text: "ダンジョン")   // タブボタン ダンジョン
        tabBotton(x: defaultX+tabWidth+5,imageName: "mushi_mijinko.png", text: "モンスター")   // タブボタン モンスター
        tabBotton(x: defaultX+(tabWidth+5)*2,imageName: "jewel.png", text: "ショップ")   // タブボタン ショップ
        tabBotton(x: defaultX+(tabWidth+5)*3,imageName: "golden_egg.png", text: "ガチャ")   // タブボタン ガチャ
    }
    
    // ユーザー情報ラベル
    func userInfoLabel(x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat, text:String, textColor:UIColor, textAlignment:NSTextAlignment, bgColor:UIColor){
        let label = UILabel(frame: CGRect(x: x, y: y, width: width, height: height))
        
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.text = " " + text      // 表示する文字を代入する.
        label.textColor = textColor      // 文字の色
        label.layer.masksToBounds = true      // 角に丸みをつける.
        label.layer.cornerRadius = 6.0      // 丸みのサイズを設定する.
        label.layer.borderWidth = 2      // 枠線の太さを設定する.
        label.layer.borderColor = UIColor.blue.cgColor      // 枠線の色
        label.textAlignment = textAlignment     // 中央揃え
        //label.layer.shadowOpacity = 10      // 影の濃さを設定する.
        label.backgroundColor = bgColor      // 背景色
        //label.delegate = self   // Delegateを自身に設定する
        view.addSubview(label)      // Viewに追加する
    }
    
//    // モンスターパーティの各タイル数字のボタン
//    func monsterPartyButton(x: CGFloat, y: CGFloat, imageName:String, text:String, tileNum: Int){
//        let btn = UIButton()    // ボタン
//        btn.frame = CGRect(x:x, y:y, width:monsterWidth, height:monsterWidth)           // 位置とサイズ
//        let img = UIImage(named: imageName)
//        btn.setBackgroundImage(img, for: .normal)
//        btn.setTitle(text, for:UIControl.State.normal)        // タイル数字文字
//        btn.titleLabel?.font =  UIFont.systemFont(ofSize: 20)        // フォントサイズ
//        btn.setTitleColor(UIColor.black, for: .normal) // タイトルの色
//        btn.titleEdgeInsets = UIEdgeInsetsMake(40, 40, 0, 0)
//        btn.backgroundColor = UIColor.gray        // 背景色
//        btn.layer.borderColor = UIColor.brown.cgColor  // 枠線の色
//        btn.layer.borderWidth = 3.0 // 枠線の太さ
//        btn.layer.masksToBounds = true      // 角に丸みをつける.
//        btn.layer.cornerRadius = 6.0      // 丸みのサイズを設定する.
//        btn.addAction(.init { _ in monsterParty[tileNum] = clione }, for: .touchUpInside)
////        btn.addTarget(self, action: #selector(monsterParty[tileNum] = clione), for: .touchUpInside)
//        view.addSubview(btn)    // Viewにボタンを追加
//    }
//    
    // モンスターボックス
    func eachMonsterButton(x:CGFloat, y:CGFloat, imageName:String){
        let btn = UIButton()    // ボタン
        btn.frame = CGRect(x:x, y:y, width:eachMonsterWidth, height:eachMonsterWidth)           // 位置とサイズ
        let img = UIImage(named: imageName)
        btn.setBackgroundImage(img, for: .normal)
        btn.backgroundColor = UIColor.gray        // 背景色
        btn.layer.borderColor = UIColor.black.cgColor  // 枠線の色
        btn.layer.borderWidth = 3.0 // 枠線の太さ
        btn.layer.masksToBounds = true      // 角に丸みをつける.
        btn.layer.cornerRadius = 6.0      // 丸みのサイズを設定する.
        //        btn.addAction(.init { _ in monsterParty[tileNum] = clione }, for: .touchUpInside)
        view.addSubview(btn)    // Viewにボタンを追加
    }
    
    // タブボタンを設定
    func tabBotton(x: CGFloat, imageName:String, text:String){
        let tabButton = UIButton()    // タブボタン
        tabButton.frame = CGRect(x:x, y:vcHeight - tabWidth - defaultY, width:tabWidth, height:tabWidth)           // 位置とサイズ
        let img = UIImage(named: imageName)
        tabButton.setBackgroundImage(img, for: .normal)
        tabButton.setTitle(text, for:UIControl.State.normal)        // タイトル
        tabButton.titleLabel?.font =  UIFont.systemFont(ofSize: 13)        // フォントサイズ
        tabButton.setTitleColor(UIColor.black, for: .normal) // タイトルの色
        tabButton.titleEdgeInsets = UIEdgeInsetsMake(40, 0, 0, 0)
        tabButton.backgroundColor = UIColor.lightGray        // 背景色
        tabButton.layer.borderColor = UIColor.brown.cgColor  // 枠線の色
        tabButton.layer.borderWidth = 5.0 // 枠線の太さ
//        tabButton.addTarget(self, action: #selector(NumberTileGameViewController.recoveryButtonTapped(sender:)), for: .touchUpInside)
        view.addSubview(tabButton)    // Viewにボタンを追加
    }

}
