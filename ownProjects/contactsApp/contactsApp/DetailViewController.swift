//
//  ItemViewController.swift
//  contactsApp
//
//  Created by Marina Beatriz Santana de Aguiar on 26.06.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var passedContact: Contact!
    var rootVC: ViewController!
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var deleteButton: UIButton!
    
    override func viewDidLoad() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardGesture))
        view.addGestureRecognizer(gesture)
        
        // Coming from ContactsInfoViewController (no rootVC)
        if passedContact != nil {
            firstNameTextField.text = passedContact.firstName
            lastNameTextField.text = passedContact.lastName
            deleteButton.isHidden = false
        }
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        if passedContact == nil {
            dismiss(animated: true)
            return
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        guard !(firstNameTextField.text?.isEmpty)!, !(lastNameTextField.text?.isEmpty)! else { dismiss(animated: true); return }
        
        if passedContact == nil {
            // Coming from ViewController
            let firstName = firstNameTextField.text!.capitalized
            let lastName = lastNameTextField.text!.capitalized
            
            // The completion handler is called after the viewDidDisappear(_:) method is called on the presented view controller.
            rootVC.dataSource.contacts.append(Contact(firstName: firstName, lastName: lastName))
            // Must use delegate because closing a modal does not call viewDidLoad on the preceding view controller
            rootVC.delegate.savedContact()
            dismiss(animated: true)
        } else { // Coming from ContactsInfoViewController (no rootVC)
            // Update contact's info
            passedContact.firstName = firstNameTextField.text!
            passedContact.lastName = lastNameTextField.text!
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        rootVC.delegate.deletedContact(contact: passedContact)
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc
    func dismissKeyboardGesture() {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
    }
}
