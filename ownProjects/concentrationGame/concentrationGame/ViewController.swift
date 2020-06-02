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
    var cardsUp = [UIButton]()
    var emojiCards = [EmojiCard]()
    
    @IBOutlet var allEmojis: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCards()
        showEmojisOnScreen()
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
            for card in emojiCards {
                if (card.representingTuple.0 == cardsUp[0].tag && card.representingTuple.1 == cardsUp[1].tag) ||
                    (card.representingTuple.1 == cardsUp[0].tag && card.representingTuple.0 == cardsUp[1].tag) {
                    title = "RIGHT"
                    break
                } else {
                    title = "WRONG"
                }
            }
            // turn turned up cards down again
            //perform(#selector(turnUpCardsDown), with: nil, afterDelay: 3)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                self.turnUpCardsDown()
                self.cardsUp.removeAll()
            }
        }
    }
    
    func turnUpCardsDown() {
        for card in cardsUp {
            UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
                card.backgroundColor = UIColor.orange
                card.setTitle("", for: .normal)
            }, completion: nil)
        }
    }
    
    private func setUpCards() {
        showEmojisOnScreen()
        for button in allEmojis {
            button.titleLabel?.font = UIFont(name: "Helvetica", size: 75)
            button.backgroundColor = UIColor.orange
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
    }


}

