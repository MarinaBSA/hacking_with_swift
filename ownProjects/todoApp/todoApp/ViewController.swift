//
//  ViewController.swift
//  todoApp
//
//  Created by Marina Beatriz Santana de Aguiar on 03.06.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import UIKit

extension String {
    func appendToEOF(_ fileURL: URL,_ fileInput: String) throws {
            if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
                defer {
                    fileHandle.closeFile()
                }
                fileHandle.seekToEndOfFile()
                if let input = ("\n" + fileInput).data(using: .utf8) {
                    fileHandle.write(input)
                }
            }
            else {
                print("Could not append text to end of file")
            }
    }
}

class ViewController: UITableViewController {

    let fileName = "items"
    let extensionName = "txt"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "To do"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(
        barButtonSystemItem: .add, target: self, action: #selector(showAlertToAskForInput))
    }
    
    
    @objc
    private func showAlertToAskForInput() {
        let alert = UIAlertController(title: "New item", message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {
            textField in
            textField.placeholder = "Apples"
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        // How could I access alert from a separate method instead of a closure
        //alert.addAction(UIAlertAction(title: "Enter", style: .destructive, handler: addItem))
        
        alert.addAction(UIAlertAction(title: "Enter", style: .destructive, handler: {
            [weak alert, weak self] (_) in
            if let text = alert?.textFields![0].text! {
                self?.writeUserInputToFile(itemToAdd: text)
            }
            
        }))
        present(alert, animated: true)
    }
    

    private func writeUserInputToFile(itemToAdd: String) {
        let fm = FileManager.default
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName).appendingPathExtension(extensionName)
        if !fm.fileExists(atPath: fileURL.path) {
            do {
                try itemToAdd.write(to: fileURL, atomically: true, encoding: .utf8)
                print("File successfully created")
            } catch {
                print("File could not be created")
            }
        } else {
            do {
                try itemToAdd.appendToEOF(fileURL, itemToAdd)
            } catch {
                print(error)
            }
        }
        print("FILE CONTENT:    \(readingFromFile())")

    }
    
    private func readingFromFile() -> [String] {
        let fm = FileManager.default
        if let data = fm.contents(atPath: getDocumentsDirectory().appendingPathComponent(fileName).appendingPathExtension(extensionName).path) {
            let contentsArray = String(decoding: data, as: UTF8.self).split(separator: "\n")
            return contentsArray.map({String($0)})
        }
        return [String]()
    }
    
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
