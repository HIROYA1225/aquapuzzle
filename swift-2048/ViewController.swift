//
//  ViewController.swift
//  swift-2048
//
//  Created by Austin Zheng on 6/3/14.
//  Copyright (c) 2014 Austin Zheng. Released under the terms of the MIT license.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startGameButtonTapped(_ sender : UIButton) {
        let game = NumberTileGameViewController(dimension: 4, threshold: 2048)
        game.modalPresentationStyle = .fullScreen
        self.present(game, animated: true, completion: nil)
    }
    
    // Log inボタン押下時
    @IBAction func loginButtonTapped(_ sender: Any) {
        // UIKitからSwiftUIへの画面遷移
        let swiftUIView = loginView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        // ログイン画面へ遷移
        self.present(hostingController, animated: true, completion: nil)
    }
    
}
