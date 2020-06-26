//
//  Contact.swift
//  contactsApp
//
//  Created by Marina Beatriz Santana de Aguiar on 01.06.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import Foundation

class Contact: Comparable {
    let name: String

    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.name == rhs.name
    }    
    
    static func <(lsh: Contact, rhs: Contact) -> Bool {
        return lsh.name < rhs.name
    }
    
    static func <=(lsh: Contact, rhs: Contact) -> Bool {
        return lsh.name <= rhs.name
    }
    
    static func >(lsh: Contact, rhs: Contact) -> Bool {
        return lsh.name > rhs.name
    }
    
    static func >=(lsh: Contact, rhs: Contact) -> Bool {
        return lsh.name >= rhs.name
    }
    
    init(name: String) {
        self.name = name
    }
}

struct Initial: Comparable {
    var letter: String
    var appearances = 1
    
    static func < (lhs: Initial, rhs: Initial) -> Bool {
        return lhs.letter.uppercased() < rhs.letter.uppercased()
    }
}

class ContactsList {
    static var contacts = [Contact]()
}
