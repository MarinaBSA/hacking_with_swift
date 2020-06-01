//
//  ViewController.swift
//  contactsApp
//
//  Created by Marina Beatriz Santana de Aguiar on 31.05.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    let cellId = "Contact"
    let fileName = "contactsPopulate"
    let fileType = "txt"
    var fileContent: String!
    var allContacts = [String]()
    var contacts = [Contact]()
    var contactsTableTemp = [Contact]()
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
        
        let path = Bundle.main.path(forResource: fileName, ofType: fileType) // file path for file "data.txt"
        fileContent = try! String(contentsOfFile: path!, encoding: .utf8)
        
        readContentFileToArray()
        countSections()
        contactsTableTemp = contacts
    }
    
    
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }*/
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let letterOfSection = initialsArray[indexPath.section]
        let contactIndex = contactsTableTemp.firstIndex(where: {$0.name.hasPrefix(letterOfSection)})!
        cell.textLabel?.text = contactsTableTemp[contactIndex].name
        contactsTableTemp.remove(at: contactIndex)
        /*for contact in contactsTemp {
            print("\(contact.name)")
        }
        print("-------")*/
        return cell
    }
    
   
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //return "A"
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
     
    
    private func countSections() {
        var contact: Contact!
        var initial: Initial!
        var letterCounter = 0
        var initialLetter = ""
        for (index, contactsName) in allContacts.enumerated() {
            if (index == 0) {
                initialLetter = String(contactsName[contactsName.startIndex])
                letterCounter += 1
                // insert current letter for the first time in array of contacts
                contact = Contact(name: contactsName)
                initial = Initial(letter: initialLetter, appearances: letterCounter)
                updateContactListAndLetter(contact!, initial!)
                continue
            } else {
                if (contactsName.hasPrefix(initialLetter) && initialLetter != "") {
                    letterCounter += 1
                    // current letter == previous letter -> update amount of appearences
                    updateLetterAppearences(firstLetter: initialLetter, newNumberOfAppearences: letterCounter)
                    updateContactListAndLetter(Contact(name: contactsName), nil)
                } else {
                    // current letter != previous letter -> insert new letter in array of contacts
                    initialLetter = String(contactsName[contactsName.startIndex])
                    letterCounter = 1
                    contact = Contact(name: contactsName)
                    initial =  Initial(letter: initialLetter, appearances: letterCounter)
                    updateContactListAndLetter(contact, initial)
                }
            }
            
        }
        
        /*
        for initial in initials {
            print("\(initial.letter): \(initial.appearances)")
        }
        for contact in contacts {
            print("\(contact.name)")
        }*/
    }
    
    private func readContentFileToArray() {
        let contactsTemp = fileContent!.split(separator: "\n")
        for contact in contactsTemp {
            allContacts.append(String(contact))
        }
        // sorting lexicographically
        allContacts = allContacts.sorted()
    }
    
    private func updateLetterAppearences(firstLetter: String, newNumberOfAppearences: Int) {
        initials[initials.firstIndex(where: {$0.letter == firstLetter})!].appearances = newNumberOfAppearences
    }
    
    private func updateContactListAndLetter(_ contactsName: Contact, _ nameInitial: Initial?) {
        contacts.append(contactsName)
        if let initial = nameInitial {
            initials.append(initial)
        }
    }

}

