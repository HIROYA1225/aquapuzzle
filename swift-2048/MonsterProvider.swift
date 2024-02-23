//
//  MonsterProvider.swift
//  swift-2048
//
//  Created by YOSUKE on 2023/11/11.
//  Copyright © 2023 Austin Zheng. All rights reserved.
//
//  生き物のデータ管理

import SwiftUI

// 生き物のインスタンス
let mijinko = creature(level: 1, rarity: 0.5, imageName: "mushi_mijinko.png")
let planaria = creature(level: 1, rarity: 0.5, imageName: "planaria.png")
let clione = creature(level: 2, rarity: 1, imageName: "fish_clione.png")
let mendako = creature(level: 3, rarity: 1, imageName: "shinkai_mendako_open.png")
let tatsunootoshigo = creature(level: 4, rarity: 1, imageName: "tatsunootoshigo.png")
let harisenbon = creature(level: 5, rarity: 1, imageName: "harisenbon.png")
let akaei = creature(level: 6, rarity: 1, imageName: "akaei.png")
let ikkaku = creature(level: 7, rarity: 1, imageName: "ikkaku.png")
let dolphin = creature(level: 8, rarity: 1, imageName: "dolphin.png")
let ryugunotsukai = creature(level: 9, rarity: 1, imageName: "ryugunotsukai.png")
let megalodon = creature(level: 10, rarity: 1, imageName: "megalodon.png")
let jinbeizame = creature(level: 11, rarity: 1, imageName: "jinbeizame.png")
let daiouika = creature(level: 12, rarity: 1, imageName: "daiouika.png")

// 生き物図鑑
var creatureBook = [mijinko, planaria, clione, mendako, tatsunootoshigo, harisenbon, akaei, ikkaku, dolphin, ryugunotsukai, megalodon, jinbeizame, daiouika]

//生き物 グループ ※進化レベルごとに分ける？
var creatureGroup = [mijinko, clione, mendako, harisenbon, akaei, ikkaku, ryugunotsukai, megalodon, jinbeizame, daiouika]

//生き物 構造体
struct creature {
    var level: Int    // 進化レベル
    var rarity: Double   // レア度
    var imageName: String  //画像ファイル名
}
