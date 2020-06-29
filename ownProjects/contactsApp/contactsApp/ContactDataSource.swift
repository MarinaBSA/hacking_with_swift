//
//  TableDataViewController.swift
//  contactsApp
//
//  Created by Marina Beatriz Santana de Aguiar on 27.06.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import UIKit

class ContactDataSource: NSObject, UITableViewDataSource {
    
    let cellId = "Contact"

    var isFiltering = false

    var contacts = [Contact]()
    var filteredContacts = [Contact]()
       
    var initials = [String]()
    var filteredInitials = [String]()
    
    var filterText: String? {
        didSet {
            isFiltering = true
            filteredInitials = initials.filtering(letter: filterText!)
            filteredContacts = contacts.filtering(input: filterText!)
        }
    }
 
    // TableView //////////////////////////////////////////////////////////////////////////////////
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = retrieveRowText(with: indexPath)
        return cell
    }
      
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return isFiltering ? filteredInitials[section] : initials[section]
    }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? getFrequencyOfInitial(sectionLetter: filteredInitials[section]) : getFrequencyOfInitial(sectionLetter: initials[section])
    }
      
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return isFiltering ? filteredInitials : initials
    }
      
    func numberOfSections(in tableView: UITableView) -> Int {
        return isFiltering ? filteredInitials.count : initials.count
    }
    
    // Functions //////////////////////////////////////////////////////////////////////////////////
    
    func getContact(indexPath: IndexPath) -> Contact {
        let allContacts = isFiltering ? filteredContacts : contacts
        let letterOfSection = isFiltering ? filteredInitials[indexPath.section] : initials[indexPath.section]

        let firstIndex = allContacts.firstIndex(where: {$0.firstName.hasPrefix(letterOfSection)})!
        let indexOfName = allContacts.index(indexPath.row, offsetBy: firstIndex)
        return allContacts[indexOfName]
     }
    
    func retrieveRowText(with indexPath: IndexPath) -> String {
        let contact = getContact(indexPath: indexPath)
        return "\(contact.firstName) \(contact.lastName)"
    }
    
    func getIndexPath(contact: Contact) -> IndexPath {
        let section = initials.firstIndex(where: {$0 == String(contact.firstName[contact.firstName.startIndex])})!
        let row = isFiltering ?
            filteredContacts.distance(from: section, to: (filteredContacts.firstIndex(where: {$0.firstName == contact.firstName && $0.lastName == contact.lastName})!))
            : contacts.distance(from: section, to: (contacts.firstIndex(where: {$0.firstName == contact.firstName && $0.lastName == contact.lastName})!))
        return IndexPath(row: row, section: section)
    }
     
    func getInitial(contact: Contact) -> String {
        return String(contact.firstName[contact.firstName.startIndex])
     }
     
     func addInitial(nameInitial: String) {
        if isFiltering, !filteredInitials.contains(nameInitial) {
            filteredInitials.append(nameInitial)
        } else if !initials.contains(nameInitial) {
            initials.append(nameInitial)
        }
    }
    
    func deleteContact(contact: Contact) {
        contacts.removeAll(where: {$0.firstName == contact.firstName && $0.lastName == contact.lastName})
        if getFrequencyOfInitial(sectionLetter: getInitial(contact: contact)) == 0 {
            initials.removeAll(where: {$0 == getInitial(contact: contact)})
        }
        
    }
    
    func getFrequencyOfInitial(sectionLetter: String) -> Int {
        let allContacts = isFiltering ? filteredContacts : contacts
        return allContacts.filter({getInitial(contact: $0) == sectionLetter}).count
    }
}


