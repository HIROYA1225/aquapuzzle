//
//  TileView.swift
//  swift-2048
//
//  Created by Austin Zheng on 6/3/14.
//  Copyright (c) 2014 Austin Zheng. Released under the terms of the MIT license.
//

import UIKit

/// A view representing a single swift-2048 tile.
class TileView : UIView {
  var value : Int = 0 {
    didSet {
      backgroundColor = delegate.tileColor(value)
      tileImageView = delegate.tileImageView(value)
      numberLabel.textColor = delegate.numberColor(value)
      numberLabel.text = "\(Int(log2(Double(value)) - 1) )" // 底が2の対数の値に変換して-1
    }
  }

  unowned let delegate : AppearanceProviderProtocol
  let numberLabel : UILabel
  var tileImageView : UIImageView

  required init(coder: NSCoder) {
    fatalError("NSCoding not supported")
  }
    
  init(position: CGPoint, width: CGFloat, value: Int, radius: CGFloat, delegate d: AppearanceProviderProtocol) {
    delegate = d
    numberLabel = UILabel(frame: CGRect(x: 20, y: 15, width: width, height: width)) //タイルの数字の配置、サイズ
    numberLabel.textAlignment = NSTextAlignment.center  //タイルの数字配置
    numberLabel.minimumScaleFactor = 0.5
    numberLabel.font = delegate.fontForNumbers()
      
    let convertedValue = Int(log2(Double(value))) - 1    // 底が2の対数での値に変換して-1
    self.tileImageView = delegate.tileImageView(value)  // タイル画像
    tileImageView.frame = CGRect(x: 0, y: 0, width: width, height: width)   // タイル画像の位置とサイズ

    super.init(frame: CGRect(x: position.x, y: position.y, width: width, height: width))
      
    addSubview(tileImageView)   // タイル画像表示
    addSubview(numberLabel)     // タイル数字表示
    layer.cornerRadius = radius
    
    self.value = value
    backgroundColor = delegate.tileColor(value)
    tileImageView = delegate.tileImageView(value)  // タイル画像
    numberLabel.textColor = delegate.numberColor(value)
    numberLabel.text = "\(convertedValue)" // 底が2の対数での値に変換して-1
  }
}
