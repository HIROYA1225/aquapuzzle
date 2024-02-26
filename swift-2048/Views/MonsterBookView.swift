//
//  MonsterBookView.swift
//  swift-2048
//
//  Created by HIRO on 2024/02/14.
//  Copyright © 2024 Austin Zheng. All rights reserved.
//

import SwiftUI

struct Monsters {
    let name: String
    let discovered: Bool
    let image: String // Image name
}

struct MonsterBookView: View {
    let monsters: [Monsters]
    
    var body: some View {
        VStack {
            ForEach(0..<2) { row in
                HStack {
                    ForEach(0..<5) { column in
                        let index = row * 5 + column
                        MonsterCell(monster: monsters[index])
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct MonsterCell: View {
    let monster: Monsters
    
    var body: some View {
        VStack {
            if monster.discovered {
                Image(systemName:monster.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            } else {
                Image(systemName: "questionmark.square.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
            Text(monster.name)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ContentView: View {
    let monsters: [Monsters] = [
        Monsters(name: "タイ", discovered: true, image: "fish"),
        Monsters(name: "マグロ", discovered: true, image: "fish.fill"),
        Monsters(name: "サバ", discovered: true, image: "fish"),
        Monsters(name: "クジラ", discovered: true, image: "fish.fill"),
        Monsters(name: "イカ", discovered: true, image: "fish"),
        Monsters(name: "Monster6", discovered: false, image: ""),
        Monsters(name: "Monster7", discovered: false, image: ""),
        Monsters(name: "Monster8", discovered: false, image: ""),
        Monsters(name: "Monster9", discovered: false, image: ""),
        Monsters(name: "Monster10", discovered: false, image: "")
    ]
    
    var body: some View {
        MonsterBookView(monsters: monsters)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


