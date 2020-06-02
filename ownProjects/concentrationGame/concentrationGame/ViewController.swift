//
//  ViewController.swift
//  concentrationGame
//
//  Created by Marina Beatriz Santana de Aguiar on 02.06.20.
//  Copyright © 2020 Marina Beatriz Santana de Aguiar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let emojis = ["🐸","🦊", "🐭", "🐶"]
    let maximumAmountOfCardsOpen = 2
    var twoCardsOpen: Bool {
        get {
            return cardsUp.count == maximumAmountOfCardsOpen
        }
    }
    var guessesLeft: Int {
        get {
            return maximumGuesses - amountOfGuesses
        }
    }
    var amountOfGuesses = 0
    var maximumGuesses = 8
    var gameCounter = 0
    var maximumCounter = 4
    var cardsUp = [UIButton]()
    var emojiCards = [EmojiCard]()
    let rightGuess = "RIGHT"
    let wrongGuess = "WRONG"
    
    @IBOutlet var allEmojis: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCards()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func emojiPressed(_ sender: UIButton) {
        for card in emojiCards {
            if(card.associatedTag == sender.tag) {
                sender.backgroundColor = UIColor.black
                sender.setTitle(card.emoji, for: .normal)
            }
        }
        
        cardsUp.append(sender)
        //  save last tag and check if the last tag and the current tag belong to the same tuple
        if(twoCardsOpen) {
            let firstTag = cardsUp[0].tag
            let secTag = cardsUp[1].tag
            let result = emojiCards.contains(where: {
                ($0.representingTuple.0 == firstTag && $0.representingTuple.1 == secTag) ||
                    ($0.representingTuple.0 == secTag && $0.representingTuple.1 == firstTag)
                
            })
            if (result) {
                gameCounter += 1
                changeTitle(rightGuess, guessesLeft)
                self.cardsUp.removeAll()
                checkGame()
                return
            }
            
            amountOfGuesses += 1
            changeTitle(wrongGuess, guessesLeft)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                self.turnUpCardsDown()
                self.cardsUp.removeAll()
            }
        }
        checkGame()
    }
    
    @IBAction func pressedRestartButton(_ sender: UIButton) {
        restartGame(action: nil)
    }
    
    
    private func checkGame() {
        if (gameCounter == maximumCounter) {
            let ac = UIAlertController(title: "Game finished", message: "Congratulations", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: restartGame))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(ac, animated: true)
        } else if (guessesLeft == 0) {
            let ac = UIAlertController(title: "Game over", message: "You lost", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: restartGame))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(ac, animated: true)
        }
    }
    
    private func restartGame(action: UIAlertAction?){
        amountOfGuesses = 0
        gameCounter = 0
        changeTitle(nil, guessesLeft)
        cardsUp.removeAll()
        emojiCards.removeAll()
        setUpCards()
    }
    
    private func turnUpCardsDown() {
        for card in cardsUp {
            UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
                card.backgroundColor = UIColor.systemOrange
                card.setTitle("", for: .normal)
            }, completion: nil)
        }
    }
    
    
    private func setUpCards() {
        showEmojisOnScreen()
        for button in allEmojis {
            button.setTitle("", for: .normal)
            button.titleLabel?.font = UIFont(name: "Helvetica", size: 75)
            button.backgroundColor = UIColor.systemOrange
        }
    }
    
    private func showEmojisOnScreen() {
        // why can't I shuffle arrayOfNumbers on the same line it is declared
        let arrayOfNumbers = [0, 1 , 2, 3, 4, 5, 6, 7]
        var shuffledNumberd = arrayOfNumbers.shuffled()
        var indexes = [0, 1, 2, 3]
        for _ in 0...3 {
            let firstNum = shuffledNumberd.removeFirst()
            let secNum = shuffledNumberd.removeLast()
            if let randomIndex = indexes.randomElement() {
                indexes.removeAll(where: {$0 == randomIndex})
                for button in allEmojis {
                    if (button.tag == firstNum || button.tag == secNum){
                        emojiCards.append(EmojiCard(representingTuple: (firstNum, secNum), associatedTag: button.tag, emoji: emojis[randomIndex]))
                    }
                }
            }
        }
        //print(emojiCards)
    }
    
    private func changeTitle(_ result: String?, _ guessesAmount: Int) {
        if let titleTxt = result {
            title = "\(titleTxt) | \(guessesAmount) guesses left"
            return
        }
        
        title = "\(guessesAmount) guesses left"
    }


}

