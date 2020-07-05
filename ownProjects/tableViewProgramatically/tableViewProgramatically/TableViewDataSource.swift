//
//  TableViewDataSource.swift
//  tableViewProgramatically
//
//  Created by Marina Beatriz Santana de Aguiar on 05.07.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    static let users = ["Jon Snow", "Daenerys Targaryen", "Arya Stark", "Cersei Lannister", "Tyron Lannister"]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseId, for: indexPath) as! TableViewCell
        return cell
    }
    
    static func getRandomUser() -> String {
        return TableViewDataSource.users.randomElement()!
    }
    
    
}
