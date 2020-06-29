//
//  ViewController.swift
//  contactsApp
//
//  Created by Marina Beatriz Santana de Aguiar on 31.05.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var delegate: ContactTableProtocol!
    let navigationTitle = "Contacts"
    let contacsInfoVCId = "ContactsInfo"
    let dataSource = ContactDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        tableView.dataSource = dataSource

        title = navigationTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        
        // Search
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "John Doe"
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        navigationItem.searchController = searchController
        
    }
    
    /* DON'T DELETE ME */
    /*override func viewWillAppear(_ animated: Bool) {
        //If a view controller is presented by a view controller inside of a popover,
        this method is not invoked on the presenting view controller after the presented controller is dismissed.
    }*/
    
    @objc
    func addItem() {
        performSegue(withIdentifier: "contactSegue", sender: self)
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "contactSegue" {
            let itemVC = segue.destination as! DetailViewController
            itemVC.rootVC = self
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: contacsInfoVCId) as? ContacsInfoViewController
        if let newView = vc {
            vc?.passedContact = dataSource.getContact(indexPath: indexPath)
            vc?.rootVC = self
            navigationController?.pushViewController(newView, animated: true)
        }
     }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}

extension ViewController: ContactTableProtocol {
    func savedContact() {
        if let contact = ContactsList.contacts.last {
            dataSource.updateListOfInitials(contact: contact)
        }
        ContactsList.contacts.sort()
        dataSource.initials.sort()
        tableView.reloadData()
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // first name starts with the inserted letter
        if let userInput = searchController.searchBar.text, !userInput.isEmpty {
            dataSource.filterText = searchController.searchBar.text!
            tableView.reloadData()
        }
        // last name starts with the inserted letter
    }
}

extension ViewController: UISearchControllerDelegate {
    func didDismissSearchController(_ searchController: UISearchController) {
        dataSource.isFiltering = false
        tableView.reloadData()
    }
}
   



