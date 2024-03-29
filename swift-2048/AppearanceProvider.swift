//
//  AppearanceProvider.swift
//  swift-2048
//
//  Created by Austin Zheng on 6/3/14.
//  Copyright (c) 2014 Austin Zheng. Released under the terms of the MIT license.
//

import UIKit

protocol AppearanceProviderProtocol: class {
  func tileColor(_ value: Int) -> UIColor
  func tileImageView(_ value: Int) -> UIImageView
  func numberColor(_ value: Int) -> UIColor
  func fontForNumbers() -> UIFont
}

class AppearanceProvider: AppearanceProviderProtocol {

  // 数値ごとのタイルの背景色
  func tileColor(_ value: Int) -> UIColor {
    switch value {
    case 2:
      return UIColor(red: 238.0/255.0, green: 228.0/255.0, blue: 218.0/255.0, alpha: 1.0)
    case 4:
      return UIColor(red: 237.0/255.0, green: 224.0/255.0, blue: 200.0/255.0, alpha: 1.0)
    case 8:
      return UIColor(red: 242.0/255.0, green: 177.0/255.0, blue: 121.0/255.0, alpha: 1.0)
    case 16:
      return UIColor(red: 245.0/255.0, green: 149.0/255.0, blue: 99.0/255.0, alpha: 1.0)
    case 32:
      return UIColor(red: 246.0/255.0, green: 124.0/255.0, blue: 95.0/255.0, alpha: 1.0)
    case 64:
      return UIColor(red: 246.0/255.0, green: 94.0/255.0, blue: 59.0/255.0, alpha: 1.0)
    case 128:
      return UIColor(red: 237.0/255.0, green: 207.0/255.0, blue: 114.0/255.0, alpha: 1.0)
    case 256:
      return UIColor(red: 237.0/255.0, green: 207.0/255.0, blue: 114.0/255.0, alpha: 1.0)
    case 512:
      return UIColor(red: 237.0/255.0, green: 207.0/255.0, blue: 114.0/255.0, alpha: 1.0)
    case 1024:
      return UIColor(red: 237.0/255.0, green: 207.0/255.0, blue: 114.0/255.0, alpha: 1.0)
    case 2048:
      return UIColor(red: 237.0/255.0, green: 207.0/255.0, blue: 114.0/255.0, alpha: 1.0)
    default:
      return UIColor.white
    }
  }
    
    // タイルの背景画像
    func tileImageView(_ value: Int) -> UIImageView {
        let convertedValue = Int(log2(Double(value))) - 1
        let imageView = UIImageView()
        // タイル数字に応じたタイル画像の設定
        if convertedValue == 0{ // タイル数字:0の場合
            imageView.image = UIImage(named: "taisaibou.png")   // タイル数字:0の画像設定
        }else{  // タイル数字:1以上の場合
            imageView.image = UIImage(named: monsterParty[convertedValue-1].imageName)   // タイル数字に応じたモンスターの画像
        }
        return imageView
    }

  // タイル数字の文字の色
  func numberColor(_ value: Int) -> UIColor {
    //switch value {
//    case 2, 4:
//      return UIColor(red: 119.0/255.0, green: 110.0/255.0, blue: 101.0/255.0, alpha: 1.0)
//    default:
      return UIColor.gray
   // }
  }

  // タイル数字のフォント
  func fontForNumbers() -> UIFont {
    if let font = UIFont(name: "HelveticaNeue-Bold", size: 20) {
      return font
    }
    return UIFont.systemFont(ofSize: 20)
  }
}
