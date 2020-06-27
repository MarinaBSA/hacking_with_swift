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
    var initialsArray: [String] {
        get {
            var temp = [String]()
            for initial in initials {
                temp.append(initial.letter)
            }
            return temp
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
        return initials[section].appearances
    }
      
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return initialsArray
    }
      
    func numberOfSections(in tableView: UITableView) -> Int {
        return initials.count
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
         let firstIndex = ContactsList.contacts.firstIndex(where: {$0.firstName.hasPrefix(letterOfSection)})!
         let indexOfName = ContactsList.contacts.index(indexPath.row, offsetBy: firstIndex)
         return ContactsList.contacts[indexOfName]
     }
    
    func retrieveRowText(with indexPath: IndexPath) -> String {
        let contact = getContact(indexPath: indexPath)
        return "\(contact.firstName) \(contact.lastName)"
    }
    
    func getIndexPath(contact: Contact) -> IndexPath {
        let section = initialsArray.firstIndex(where: {$0 == String(contact.firstName[contact.firstName.startIndex])})!
        let row = ContactsList.contacts.distance(from: section,
                                                 to: (ContactsList.contacts.firstIndex(where: {$0.firstName == contact.firstName && $0.lastName == contact.lastName})!))
        return IndexPath(row: row, section: section)
    }
     
    // Helpers //////////////////////////////////////////////////////////////////////////////////
     func getInitial(contact: Contact) -> String {
        return String(contact.firstName[contact.firstName.startIndex])
     }
     
    func updateInitialAppearences(firstLetter: String, numOfAppearances: Int) {
        let initialIndex = initials.firstIndex(where: {$0.letter == firstLetter})!
        var initial = initials[initialIndex]
        initial.appearances += numOfAppearances
        if initial.appearances == 0 {
            initials.remove(at: initialIndex)
        }
     }
     
     private func updateInitialsHelper(nameInitial: Initial?) {
        if let initial = nameInitial {
            initials.append(initial)
        }
     }
}


