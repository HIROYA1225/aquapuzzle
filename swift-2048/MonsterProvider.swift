//
//  MonsterProvider.swift
//  swift-2048
//
//  Created by YOSUKE on 2023/11/11.
//  Copyright © 2023 Austin Zheng. All rights reserved.
//

import SwiftUI

//モンスターのインスタンス
let mijinko = Monster(level: 1, rare: 1, cost: 1, HP: 10, tileNum: 1, attack: 1, recovery: 0, imageName: "mushi_mijinko.png")   // tileNum:1のモンスター
let planaria = Monster(level: 1, rare: 1, cost: 1, HP: 8, tileNum: 1, attack: 1, recovery: 1, imageName: "planaria.png")   // tileNum:1のモンスター
let clione = Monster(level: 1, rare: 1, cost: 1, HP: 20, tileNum: 2, attack: 3, recovery: 1, imageName: "fish_clione.png")  // tileNum:2のモンスター
let mendako = Monster(level: 1, rare: 1, cost: 1, HP: 30, tileNum: 3, attack: 5, recovery: 0, imageName: "shinkai_mendako_open.png")    // tileNum:3のモンスター
let tatsunootoshigo = Monster(level: 1, rare: 1, cost: 1, HP: 25, tileNum: 3, attack: 7, recovery: 0, imageName: "tatsunootoshigo.png")    // tileNum:3のモンスター
let harisenbon = Monster(level: 1, rare: 1, cost: 1, HP: 35, tileNum: 4, attack: 7, recovery: 0, imageName: "harisenbon.png")    // tileNum:4のモンスター
let akaei = Monster(level: 1, rare: 1, cost: 1 , HP: 40, tileNum: 5, attack: 10, recovery: 0, imageName: "akaei.png")    // tileNum:5のモンスター
let ikkaku = Monster(level: 1, rare: 1, cost: 1 , HP: 50, tileNum: 6, attack: 15, recovery: 0, imageName: "ikkaku.png")    // tileNum:6のモンスター
let dolphin = Monster(level: 1, rare: 1, cost: 1 , HP: 50, tileNum: 6, attack: 15, recovery: 0, imageName: "dolphin.png")    // tileNum:6のモンスター
let ryugunotsukai = Monster(level: 1, rare: 1, cost: 2, HP: 60, tileNum: 7, attack: 20, recovery: 10, imageName: "ryugunotsukai.png")    // tileNum:7のモンスター
let megalodon = Monster(level: 1, rare: 1, cost: 2, HP: 70, tileNum: 8, attack: 50, recovery: 0, imageName: "megalodon.png")    // tileNum:8のモンスター
let jinbeizame = Monster(level: 1, rare: 1, cost: 2 , HP: 100, tileNum: 9, attack: 40, recovery: 5, imageName: "jinbeizame.png")    // tileNum:9のモンスター
let daiouika = Monster(level: 1, rare: 1, cost: 2 , HP: 90, tileNum: 10, attack: 60, recovery: 0, imageName: "daiouika.png")    // tileNum:10のモンスター

// モンスターボックス
var monsterBox = [mijinko, planaria, clione, mendako, tatsunootoshigo, harisenbon, akaei, ikkaku, dolphin, ryugunotsukai, megalodon, jinbeizame, daiouika]

//モンスター パーティ
var monsterParty = [mijinko, clione, mendako, harisenbon, akaei, ikkaku, ryugunotsukai, megalodon, jinbeizame, daiouika]

//モンスター 構造体
struct Monster {
    var level: Int = 1  // レベル
    var rare: Int   // レア度
    var cost: Int   // コスト
    var HP: Int     // HP
    var tileNum: Int   // タイル数字
    var attack: Int    // 攻撃力
    var recovery: Int  // 回復力
    var imageName: String  //画像ファイル名
}
