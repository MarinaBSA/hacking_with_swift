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
    static func == (lhs: Initial, rhs: Initial) -> Bool {
        return lhs.letter == rhs.letter
    }
    
    var letter: String
    var appearances = 1
    
    static func < (lhs: Initial, rhs: Initial) -> Bool {
        return lhs.letter.uppercased() < rhs.letter.uppercased()
    }
    
    init(letter: String) {
        self.letter = letter
    }
}

class ContactsList {
    static var contacts = [Contact]()
}
