//
//  CollectionView.swift
//  collectionViewGrid
//
//  Created by Marina Beatriz Santana de Aguiar on 04.07.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import UIKit

class CollectionView: UICollectionView {
    
    //lazy var collectionLayoutFlow = UICollectionViewFlowLayout()
    var collectionLayoutFlow = UICollectionViewFlowLayout()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        collectionViewLayout = collectionLayoutFlow
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let width = frame.width
        let sectionInset: CGFloat = 50
        let itemInterSpacing: CGFloat = 50
        let itemSize = (width - (2*sectionInset) - itemInterSpacing) / 2
        
        collectionLayoutFlow.itemSize = CGSize(width: itemSize, height: itemSize)
        collectionLayoutFlow.minimumInteritemSpacing = itemInterSpacing
        collectionLayoutFlow.sectionInset = UIEdgeInsets(top: sectionInset, left: sectionInset, bottom: sectionInset/3, right: sectionInset)
    }

}
