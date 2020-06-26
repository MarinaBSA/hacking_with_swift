//
//  ViewController.swift
//  worldScramble
//
//  Created by Marina Beatriz Santana de Aguiar on 16.06.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))

        readFromFile()
        startGame()
    }
    
    
    func readFromFile() {
        if let filePath = Bundle.main.url(forResource: "start", withExtension: "txt") {
            let fileContent = try! String(contentsOf: filePath)
            allWords = fileContent.split(separator: "\n").map({String($0)})
        }
    }
    
    func randomWord() -> String {
        //let word = allWords.remove(at: Int.random(in: 0..<allWords.count))
        let word = allWords.randomElement()!
        allWords.remove(at: allWords.firstIndex(of: word)!)
        return word
    }
    
    func startGame() {
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
        title = randomWord()
    }
    
    @objc
    func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)
        ac.addAction(UIAlertAction(title: "Insert", style: .default) {
            [weak self, weak ac] _ in
            guard let userInput = ac?.textFields![0].text else {
                return
            }
            self?.submitAnswer(userInput)
            
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true)
    }
    
    func submitAnswer(_ input: String) {
        // check user's answer
        let lowerAnswer = input.lowercased()
        if isPossible(lowerAnswer), isUnused(lowerAnswer), isReal(lowerAnswer) {
            usedWords.insert(input, at: 0)
            tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
    }
    
    func isPossible(_ userInput: String) -> Bool {
        var word = userInput
        for letter in word {
            if let position = word.firstIndex(of: letter) {
                word.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(_ userInput: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: userInput.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: userInput, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    func isUnused(_ userInput: String) -> Bool {
        !usedWords.contains(userInput)
    }

  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word")!
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    

}

