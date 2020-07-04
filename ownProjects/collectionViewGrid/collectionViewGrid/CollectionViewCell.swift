//
//  collectionViewCell.swift
//  collectionViewGrid
//
//  Created by Marina Beatriz Santana de Aguiar on 04.07.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let colors = [UIColor.systemYellow, UIColor.systemBlue, UIColor.systemRed, UIColor.systemOrange, UIColor.systemGray, UIColor.systemPink]
    static let reuseIdentfier = "cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        backgroundColor = colors.randomElement()
    }
    
}


