//
//  ViewController.swift
//  tableViewProgramatically
//
//  Created by Marina Beatriz Santana de Aguiar on 05.07.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var dataSource = TableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseId)
    }


}

