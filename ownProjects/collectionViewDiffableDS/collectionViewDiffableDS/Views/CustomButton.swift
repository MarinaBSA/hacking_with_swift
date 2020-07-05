//
//  CustomButton.swift
//  collectionViewDiffableDS
//
//  Created by Marina Beatriz Santana de Aguiar on 05.07.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    var buttonTitle: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, backgroundColor: UIColor, cornerRadius: CGFloat) {
        super.init(frame: frame)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setTitle(buttonTitle, for: .normal)
    }
}
