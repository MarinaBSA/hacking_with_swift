//
//  Contact.swift
//  contactsApp
//
//  Created by Marina Beatriz Santana de Aguiar on 01.06.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import Foundation

class Contact: Comparable {
    var firstName: String
    var lastName: String

    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.firstName == rhs.firstName
    }    
    
    static func <(lsh: Contact, rhs: Contact) -> Bool {
        return lsh.firstName < rhs.firstName
    }
    
    static func <=(lsh: Contact, rhs: Contact) -> Bool {
        return lsh.firstName <= rhs.firstName
    }
    
    static func >(lsh: Contact, rhs: Contact) -> Bool {
        return lsh.firstName > rhs.firstName
    }
    
    static func >=(lsh: Contact, rhs: Contact) -> Bool {
        return lsh.firstName >= rhs.firstName
    }
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

class Initial: Comparable {
    var letter: String
    var appearances = 1
    
    static func == (lhs: Initial, rhs: Initial) -> Bool {
        return lhs.letter == rhs.letter
    }
    
    static func < (lhs: Initial, rhs: Initial) -> Bool {
        return lhs.letter.uppercased() < rhs.letter.uppercased()
    }
    
    init(letter: String) {
        self.letter = letter
    }
}

class ContactsList {
    static var contacts = [Contact]()
    static var filteredContacts = [Contact]()
}

extension Array where Element == Contact {
    func filtering(input: String) -> [Contact] {
        let filteredArray = self.filter({String($0.firstName[$0.firstName.startIndex]) == input || $0.firstName.contains(input)})
        if !filteredArray.isEmpty  {
            return filteredArray
        }
        return self
    }
}

extension Array where Element == Initial {
    func filtering(letter: String) -> [Initial] {
        let filteredArray = self.filter({String($0.letter[$0.letter.startIndex]) == String(letter[letter.startIndex])})
        if !filteredArray.isEmpty  {
            return filteredArray
        }
        return self
    }
}
