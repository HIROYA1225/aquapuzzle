//
//  MonsterView.swift
//  swift-2048
//
//  Created by YOSUKE on 2023/11/18.
//  Copyright © 2023 Austin Zheng. All rights reserved.
//

import SwiftUI

class MonsterViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // モンスター名
        let monsterNameLabel = UILabel(frame: CGRect(x: 25, y: 40, width: vcWidth * 0.9, height: 30))
        monsterNameLabel.layer.masksToBounds = true      // 角に丸みをつける.
        monsterNameLabel.layer.cornerRadius = 6.0      // 丸みのサイズを設定する.
        monsterNameLabel.layer.borderWidth = 2      // 枠線の太さを設定する.
        monsterNameLabel.layer.borderColor = UIColor.black.cgColor      // 枠線の色
        monsterNameLabel.text = "\(monsterBox[9].imageName)" + "   ☆\(monsterBox[9].rare)"      // 表示する文字を代入する.
        monsterNameLabel.textColor = UIColor.white      // 文字の色
        monsterNameLabel.textAlignment = NSTextAlignment.center     // 中央揃え
        monsterNameLabel.font = UIFont.systemFont(ofSize: 16.0)      // フォントの設定をする.
        monsterNameLabel.backgroundColor = UIColor.gray      // 背景色
        view.addSubview(monsterNameLabel)      // Viewに追加する
        
        // モンスター画像を設定
        let monsterImageView = UIImageView(frame: CGRect(x: (vcWidth-vcWidth*0.7)/2, y: (vcHeight - vcWidth) /  5, width: vcWidth*0.7, height: vcWidth*0.7)) // 画像の大きさを設定
        monsterImageView.image = UIImage(named: monsterBox[9].imageName) // 画像を設定
        self.view.addSubview(monsterImageView) // 画像を表示する
        
        // パラメータ
        let monsterDetailLabel = UILabel(frame: CGRect(x:20 , y: vcHeight*0.65, width: vcWidth * 0.9, height: vcHeight*0.2))
        monsterDetailLabel.layer.masksToBounds = true      // 角に丸みをつける.
        monsterDetailLabel.layer.cornerRadius = 6.0      // 丸みのサイズを設定する.
        monsterDetailLabel.layer.borderWidth = 2      // 枠線の太さを設定する.
        monsterDetailLabel.layer.borderColor = UIColor.black.cgColor      // 枠線の色
        monsterDetailLabel.backgroundColor = UIColor.gray      // 背景色
        view.addSubview(monsterDetailLabel)      // Viewに追加する
        
    }
    
}

