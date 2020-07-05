//
//  ViewController.swift
//  collectionViewDiffableDS
//
//  Created by Marina Beatriz Santana de Aguiar on 05.07.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import UIKit

typealias diffableSnapshot = NSDiffableDataSourceSnapshot<Section, Item>

class ViewController: UIViewController {

    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    var collectionView: UICollectionView!
    var collectionItems = [Item]()
    
    override func viewDidLoad() {
        configureCollectionView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(showDeleteAllItemsAlert))
    }
    
    @objc func showDeleteAllItemsAlert() {
        let alert = CustomAlert(title: "Warning", message: "Do you really wanna delete all items?")
        alert.delegate = self
        present(alert, animated: true)
    }
   
    func deleteAllItems() {
        collectionItems.removeAll(keepingCapacity: true)
        update()
    }
    
    @objc func addItem() {
        collectionItems.append(Item())
        update()
    }
       
    func update() {
        let snapshot = setupSnapshot(with: collectionItems)
        configureDataSource(with: snapshot)
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: CollectionViewHelper.createTwoColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = dataSource
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
    }
    
    func setupSnapshot(with items: [Item]) -> diffableSnapshot {
        var snapshot = diffableSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        return snapshot
    }
    
    func configureDataSource(with snapshot: diffableSnapshot) {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as? CollectionViewCell else {
                fatalError("Cannot create new cell")
            }
            return cell
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ViewController: AlertProtocol {
    func radicalActionButtonClicked() {
        guard !collectionItems.isEmpty else { return }
        deleteAllItems()
    }
}

