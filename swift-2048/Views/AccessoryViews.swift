//
//  AccessoryViews.swift
//  swift-2048
//
//  Created by Austin Zheng on 6/4/14.
//  Copyright (c) 2014 Austin Zheng. Released under the terms of the MIT license.
//

import UIKit
import SwiftUI

protocol ScoreViewProtocol {
  func scoreChanged(to s: Int)
}

protocol MyHPViewProtocol {
 // func scoreChanged(to s: Int)
}

/// スコアビュー(敵HP)表示
class ScoreView : UIView, ScoreViewProtocol {
  var score : Int = defaultHP {
    didSet {
      label.text = "HP: \(score)"
    }
  }

  let defaultFrame = CGRect(x: 0, y: 0, width: 140, height: 40)
  var label: UILabel

  init(backgroundColor bgcolor: UIColor, textColor tcolor: UIColor, font: UIFont, radius r: CGFloat) {
    label = UILabel(frame: defaultFrame)
    label.textAlignment = NSTextAlignment.center
    super.init(frame: defaultFrame)
    backgroundColor = bgcolor
    label.textColor = tcolor
    label.font = font
    layer.cornerRadius = r
    self.addSubview(label)
  }

  required init(coder aDecoder: NSCoder) {
    fatalError("NSCoding not supported")
  }

  func scoreChanged(to s: Int)  {   //外部引数名:to, 内部引数名:s
    score = s
  }
}

// A simple view that displays several buttons for controlling the app
class ControlView {
  let defaultFrame = CGRect(x: 0, y: 0, width: 140, height: 40)
  // TODO: Implement me
}
