//
//  CollectionViewDataSource.swift
//  collectionViewGrid
//
//  Created by Marina Beatriz Santana de Aguiar on 04.07.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import UIKit

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentfier, for: indexPath) as! CollectionViewCell
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        10
    }
}
