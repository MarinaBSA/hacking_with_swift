//
//  ViewController.swift
//  jsonParsingApp
//
//  Created by Marina Beatriz Santana de Aguiar on 09.06.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var people: PersonsData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = "https://dadosabertos.camara.leg.br/api/v2/deputados?itens=30&siglaUf=pe"

        //var request = URLRequest(url: apiURL)
        //request.httpMethod = "GET"
        //request.addValue("application/json", forHTTPHeaderField: "Accept")
        do {
            let fetchedData = try Data(contentsOf: URL(string: url)!)
            people = try JSONDecoder().decode(PersonsData.self, from: fetchedData)
        } catch {
            print("Could not parse JSON")
            print(error)
        }
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.dados.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellItem", for: indexPath)
        cell.textLabel?.text = people.dados[indexPath.row].nome
        cell.detailTextLabel?.text = people.dados[indexPath.row].siglaPartido
        
        return cell
    }
}

