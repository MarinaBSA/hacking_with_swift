//
//  File.swift
//  collectionViewDiffableDS
//
//  Created by Marina Beatriz Santana de Aguiar on 05.07.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import Foundation

struct Item: Hashable {
    let id = UUID()
    let name: String
    
    init() {
        name = Items.getRandomItem()
    }
    
    init(name: String) {
        self.name = name
    }
}

struct Items {
    static func getRandomItem() -> String {
        ["Jon Snow", "Arya Stark", "Cersei Lannister", "Tyrion Lannister", "Daenerys Targaryen", "Hodor"].randomElement()!
    }
}

enum Section {
    case main
}



