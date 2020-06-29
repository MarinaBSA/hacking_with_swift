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

    var initials = [Initial]()
    var filteredInitials = [Initial]()
    var isFiltering = false

    var initialsArray: [String] {
        get {
            let initialsArr = isFiltering ? filteredInitials : initials
            
            var temp = [String]()
            for initial in initialsArr {
                temp.append(initial.letter)
            }
            return temp
        }
    }
    
    var filterText: String? {
        didSet {
            isFiltering = true
            filteredInitials = initials.filtering(letter: filterText!)
            ContactsList.filteredContacts = ContactsList.contacts.filtering(input: filterText!)
        }
    }
 
    // TableView //////////////////////////////////////////////////////////////////////////////////
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = retrieveRowText(with: indexPath)
        return cell
    }
      
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return initialsArray[section]
    }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredInitials[section].appearances : initials[section].appearances
    }
      
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return initialsArray
    }
      
    func numberOfSections(in tableView: UITableView) -> Int {
        return isFiltering ? filteredInitials.count : initials.count
    }
    
    // Functions //////////////////////////////////////////////////////////////////////////////////
    func updateListOfInitials(contact: Contact) {
        // If initial already exists
        if initialsArray.contains(getInitial(contact: contact)) {
            let initial = getInitial(contact: contact)
            updateInitialAppearences(firstLetter: initial, numOfAppearances: 1)
        } else {
            let initialLetter = getInitial(contact: contact)
            let initial =  Initial(letter: initialLetter)
            updateInitialsHelper(nameInitial: initial)
        }
     }
    
    func getContact(indexPath: IndexPath) -> Contact {
        let letterOfSection = initialsArray[indexPath.section]
        let contacts: [Contact]!
        contacts = isFiltering ? ContactsList.filteredContacts : ContactsList.contacts

        let firstIndex = contacts.firstIndex(where: {$0.firstName.hasPrefix(letterOfSection)})!
        let indexOfName = contacts.index(indexPath.row, offsetBy: firstIndex)
        return contacts[indexOfName]
     }
    
    func retrieveRowText(with indexPath: IndexPath) -> String {
        let contact = getContact(indexPath: indexPath)
        return "\(contact.firstName) \(contact.lastName)"
    }
    
    func getIndexPath(contact: Contact) -> IndexPath {
        let section = initialsArray.firstIndex(where: {$0 == String(contact.firstName[contact.firstName.startIndex])})!
        let row = isFiltering ?
            ContactsList.filteredContacts.distance(from: section, to: (ContactsList.filteredContacts.firstIndex(where: {$0.firstName == contact.firstName && $0.lastName == contact.lastName})!))
            : ContactsList.contacts.distance(from: section, to: (ContactsList.filteredContacts.firstIndex(where: {$0.firstName == contact.firstName && $0.lastName == contact.lastName})!))
        return IndexPath(row: row, section: section)
        
    }
     
    // Helpers //////////////////////////////////////////////////////////////////////////////////
     func getInitial(contact: Contact) -> String {
        return String(contact.firstName[contact.firstName.startIndex])
     }
     
    func updateInitialAppearences(firstLetter: String, numOfAppearances: Int) {
        let initialIndex = isFiltering ? filteredInitials.firstIndex(where: {$0.letter == firstLetter})! : initials.firstIndex(where: {$0.letter == firstLetter})!
        let initial = initials[initialIndex]
        initial.appearances += numOfAppearances
        if initial.appearances == 0 {
            initials.remove(at: initialIndex)
        }
     }
     
     private func updateInitialsHelper(nameInitial: Initial?) {
        if let initial = nameInitial {
            if isFiltering {
                filteredInitials.append(initial)
                return
            }
            initials.append(initial)
        }
     }
}


