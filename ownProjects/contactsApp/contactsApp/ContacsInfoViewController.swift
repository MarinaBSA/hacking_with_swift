//
//  ContacsInfoViewController.swift
//  contactsApp
//
//  Created by Marina Beatriz Santana de Aguiar on 01.06.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import UIKit

class ContacsInfoViewController: UIViewController {

    @IBOutlet var contactsName: UITextField!
    var contactsNameText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = contactsNameText {
            contactsName.text = name
        }
    }
    

}
