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
    let cellId = "Contact"
    let contacsInfoVCId = "ContactsInfo"
    let navigationTitle = "Contacts"
    
    var initials = [Initial]()
    var initialsArray: [String] {
        get {
            var temp = [String]()
            for initial in initials {
                temp.append(initial.letter)
            }
            return temp
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        title = navigationTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
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
            let itemVC = segue.destination as! ItemViewController
            itemVC.rootVC = self
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: contacsInfoVCId) as? ContacsInfoViewController
        if let newView = vc {
            vc?.contactsNameText = retrieveNameFromRowHelper(with: indexPath)
            navigationController?.pushViewController(newView, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = retrieveNameFromRowHelper(with: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return initialsArray[section]
    }
     
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return initials[section].appearances
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return initialsArray
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return initials.count
    }
     
    private func updateListOfInitials(contact: Contact) {
        // Check if initial already exists
        if initialsArray.contains(getInitial(contact: contact)) {
            let initial = getInitial(contact: contact)
            updateInitialAppearencesHelper(firstLetter: initial)
        } else {
            let initialLetter = getInitial(contact: contact)
            let initial =  Initial(letter: initialLetter)
            updateInitialsHelper(nameInitial: initial)
        }
    }
    
    private func getInitial(contact: Contact) -> String {
        return String(contact.name[contact.name.startIndex])
    }
    
    private func updateInitialAppearencesHelper(firstLetter: String) {
        initials[initials.firstIndex(where: {$0.letter == firstLetter})!].appearances += 1
    }
    
    private func updateInitialsHelper(nameInitial: Initial?) {
        if let initial = nameInitial {
            initials.append(initial)
        }
    }
    
    private func retrieveNameFromRowHelper(with indexPath: IndexPath) -> String {
        let letterOfSection = initialsArray[indexPath.section]
        let firstIndex = ContactsList.contacts.firstIndex(where: {$0.name.hasPrefix(letterOfSection)})!
        let indexOfName = ContactsList.contacts.index(indexPath.row, offsetBy: firstIndex)
        return ContactsList.contacts[indexOfName].name
    }
}

extension ViewController: ContactTableProtocol {
    func savedName() {
        if let contact = ContactsList.contacts.last {
            updateListOfInitials(contact: contact)
        }
        ContactsList.contacts.sort()
        initials.sort()
            
        self.tableView.reloadData()
    }
}

