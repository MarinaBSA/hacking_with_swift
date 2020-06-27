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
    var passedContact: Contact!
    var rootVC: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        title = "Name of Contact" 
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let contact = passedContact {
            contactsName.text = contact.firstName + " " + contact.lastName
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editContactSegue" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.passedContact = passedContact
            detailVC.rootVC = rootVC
        }
    }

}
