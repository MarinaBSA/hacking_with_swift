//
//  ViewController.swift
//  todoApp
//
//  Created by Marina Beatriz Santana de Aguiar on 03.06.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import UIKit

extension String {
    func appendToEOF(_ fileURL: URL,_ fileInput: String) {
        if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            if let input = ("\n" + fileInput).data(using: .utf8) {
                fileHandle.write(input)
            }
        } else {
            print("Could not append text to end of file")
        }
    }
}

class ViewController: UITableViewController {

    let fileName = "items"
    let extensionName = "txt"
    let cellID = "itemCell"
    var sections = 1
    var itemsArray = [String]()

    lazy var fileURL = getDocumentsDirectory().appendingPathComponent(fileName).appendingPathExtension(extensionName)

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "To do"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(showAlertToAskForInput))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .trash, target: self, action: #selector(showAlertToDeleteTable))
        
        readingFromFile()
    }
    
    @objc 
    private func showAlertToDeleteTable() {
        let alert = UIAlertController(title: "Warning", message: "Do you really want to delete this list?", 
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: deleteWholeListFromFile))
        present(alert, animated: true)
    }

    @objc
    private func showAlertToAskForInput() {
        let alert = UIAlertController(title: "New item", message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {
            textField in
            textField.placeholder = "Apples"
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        // How could I access alert from a separate method instead of a closure?
        //alert.addAction(UIAlertAction(title: "Enter", style: .destructive, handler: addItem))
        
        alert.addAction(UIAlertAction(title: "Enter", style: .destructive, handler: {
            [weak alert, weak self] (_) in
            if let text = alert?.textFields![0].text! {
                self?.writeUserInputToFile(itemToAdd: text)
            }
        }))
        present(alert, animated: true)
    }
    
    private func deleteWholeListFromFile(action: UIAlertAction) {
        let fm = FileManager.default
        if fm.isDeletableFile(atPath: fileURL.path) {
            do {
                try fm.removeItem(at: fileURL)
                updateItemsArray(item: nil)
                sections -= 1
                if let index = tableView.indexPathsForVisibleRows {
                    // Must delete rows, can't delete the whole section in order to do that I had to change the
                    // number of sections to 0 before calling deleteRows, since the section still exists
                    // after the rows have been deleted.
                    // The method I had to override in order to do that:
                    // numberOfSections <- returns the number of sections, so after deletion the variable it returns
                    // must be equals 0
                    tableView.deleteRows(at: index, with: .automatic)
                }
            } catch {
                print(error)
                print("Could not delete file")
            }
        }
    }

    private func writeUserInputToFile(itemToAdd: String) {
        let fm = FileManager.default
        if !fm.fileExists(atPath: fileURL.path) {
            do {
                try itemToAdd.write(to: fileURL, atomically: true, encoding: .utf8)
                print("File successfully created")
            } catch {
                print(error)
                print("File could not be created")
            }
        } else {
            itemToAdd.appendToEOF(fileURL, itemToAdd)
        }
        let numOfRows = tableView.numberOfRows(inSection: 0)
        updateItemsArray(item: itemToAdd)
        
        tableView.insertRows(at: [IndexPath(row: numOfRows , section: 0)], with: .automatic)
    }
    
    // How to observe a method?
    private func readingFromFile() {
        let fm = FileManager.default
        if let data = fm.contents(atPath: fileURL.path) {
            let contentsArray = String(decoding: data, as: UTF8.self).split(separator: "\n")
            itemsArray = contentsArray.map({String($0)})
        }
    }
    
    private func updateItemsArray(item: String?) {
        if let itemToUpdate = item {
          itemsArray.append(itemToUpdate)
            return
        }
        itemsArray.removeAll()
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = itemsArray[indexPath.row]
        return cell
    }
}
