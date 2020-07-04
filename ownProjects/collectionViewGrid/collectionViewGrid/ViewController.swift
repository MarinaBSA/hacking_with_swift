//
//  ViewController.swift
//  collectionViewGrid
//
//  Created by Marina Beatriz Santana de Aguiar on 04.07.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var collectionView: UICollectionView!
    var dataSource = CollectionViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
    }
    
    func configureCollectionView() {
        collectionView = CollectionView(frame: view.frame, collectionViewLayout: UICollectionViewLayout())
        collectionView.dataSource = dataSource
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentfier)
        view.addSubview(collectionView)
    }
        
    


}
