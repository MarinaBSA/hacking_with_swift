//
//  CollectionViewHelper.swift
//  collectionViewDiffableDS
//
//  Created by Marina Beatriz Santana de Aguiar on 05.07.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import UIKit

struct CollectionViewHelper {
    static func createTwoColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let sectionInset: CGFloat = 20
        let itemInterSpacing: CGFloat = 15
        let itemSize = (width - (2*sectionInset) - itemInterSpacing) / 2
        
        let layoutFlow = UICollectionViewFlowLayout()
        layoutFlow.itemSize = CGSize(width: itemSize, height: itemSize)
        layoutFlow.minimumInteritemSpacing = itemInterSpacing
        layoutFlow.sectionInset = UIEdgeInsets(top: sectionInset, left: sectionInset, bottom: sectionInset, right: sectionInset)
        return layoutFlow
    }
    
}
