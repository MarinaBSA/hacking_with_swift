//
//  ItemViewController.swift
//  contactsApp
//
//  Created by Marina Beatriz Santana de Aguiar on 26.06.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    var firstName: String!
    var lastName: String!
    var rootVC: ViewController!
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    
    override func viewDidLoad() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardGesture))
        view.addGestureRecognizer(gesture)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: {
        })
    }
    @IBAction func doneButton(_ sender: UIButton) {
        // get values
        if !((firstNameTextField.text?.isEmpty)! && (lastNameTextField.text?.isEmpty)!) {
            let firstName = firstNameTextField.text!.capitalized
            let lastName = lastNameTextField.text!.capitalized
            
            //The completion handler is called after the viewDidDisappear(_:) method is called on the presented view controller.
            ContactsList.contacts.append(Contact(name: "\(firstName) \(lastName)"))
            rootVC.delegate.savedName()
        }
        
        dismiss(animated: true)
    }
   
    @objc
    func dismissKeyboardGesture() {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.popViewController(animated: true)
    }
    
}
