//
//  CustomAlter.swift
//  collectionViewDiffableDS
//
//  Created by Marina Beatriz Santana de Aguiar on 05.07.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import UIKit

class CustomAlert: UIViewController {
    weak var delegate: AlertProtocol!
    
    let alertController = UIAlertController()
    let containerView = UIView()
    var alertTitle: String!
    var message: String!
    
    let dismissButtonTitle = "No"
    var dismissButton: CustomButton!
    
    let confirmButtonTitle = "Yes"
    var confirmButton: CustomButton!
    
    var messageLabel: UILabel!
    var titleLabel: UILabel!
    
    let cornerRadius: CGFloat = 15
    
    init(title: String, message: String) {
        super.init(nibName: nil, bundle: nil)
        
        alertTitle = title
        self.message = message
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        view.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.70).cgColor
        configureContainerView()
        configureTitleLabel()
        configureMessageLabel()
        configureDismissButton()
        configureConfirmButton()
        
        let tappingOutsideGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAlert))
        view.addGestureRecognizer(tappingOutsideGesture)
    }

    
    private func configureContainerView() {
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.borderColor = UIColor.label.cgColor
        containerView.layer.borderWidth = 3.5
        
        NSLayoutConstraint.activate([
            // max-width 320
            // max-height 480
            containerView.widthAnchor.constraint(equalToConstant: 250),
            containerView.heightAnchor.constraint(equalToConstant: 270),
            containerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    
    private func configureTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = alertTitle
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
     
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
        ])
    }
    
    private func configureMessageLabel() {
        messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.numberOfLines = 0      // default is 1, set to 0 to use as many lines as needed
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        view.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
        ])
    }
    
    private func configureDismissButton() {
        dismissButton = CustomButton(frame: .zero, backgroundColor: UIColor.systemBlue, cornerRadius: cornerRadius)
        dismissButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        dismissButton.setTitle(dismissButtonTitle, for: .normal)
        dismissButton.setTitleColor(UIColor.label, for: .normal)
        dismissButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        view.addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dismissButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            dismissButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            dismissButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15),
            dismissButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func dismissAlert() {
        dismiss(animated: true)
    }
    
    private func configureConfirmButton() {
        confirmButton = CustomButton(frame: .zero, backgroundColor: UIColor.systemRed, cornerRadius: cornerRadius)
        confirmButton.addTarget(self, action: #selector(tellDelegateToDeleteAllItems), for: .touchUpInside)
        confirmButton.setTitle(confirmButtonTitle, for: .normal)
        confirmButton.setTitleColor(UIColor.label, for: .normal)
        confirmButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        view.addSubview(confirmButton)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            confirmButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            confirmButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            confirmButton.bottomAnchor.constraint(equalTo: dismissButton.topAnchor, constant: -10),
            confirmButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func tellDelegateToDeleteAllItems() {
        delegate.radicalActionButtonClicked()
        dismiss(animated: true)
    }
    
   

}
