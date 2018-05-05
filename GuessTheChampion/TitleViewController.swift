//
//  TitleViewController.swift
//  GuessTheChampion
//
//  Created by Jared Micheal Harding on 4/30/18.
//  Copyright © 2018 Jared Micheal Harding. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController {
    // just a global reference to the appDelegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startGame(_ sender: UIButton) {
        let answers = getRandomChampions(amount: appDelegate.rounds)
        if (sender.tag == 1) {
            // Easy was selected
            let choices = getRandomChoices(answers: answers)
            appDelegate.game = GuessTheChampion(answers: answers, choices: choices)
            performSegue(withIdentifier: "titleToEasyGame", sender: self)
        } else if (sender.tag == 2) {
            // Hard was selected
            appDelegate.game = GuessTheChampion(answers: answers)
            performSegue(withIdentifier: "titleToHardGame", sender: self)
        }
    }
    
    func getRandomChampions(amount: Int) -> [String] {
        var champions = appDelegate.allChampions
        var randomChampions: [String] = []
        for _ in 0..<amount {
            let randNum = Int(arc4random_uniform(UInt32(champions.count)))
            // removing it from the champion list ensures we get unique champions for each round
            randomChampions.append(champions.remove(at: randNum))
        }
        return randomChampions
    }
    
    func getRandomChoices(answers: [String]) -> [[String]] {
        var randomChoices: [[String]] = []
        // we are just going to add the choices in order
        for i in 0..<answers.count {
            randomChoices.append([])
            randomChoices[i].append(answers[i])
            var champions = appDelegate.allChampions
            // remove the answer champion first, so it can't be picked as another option
            champions = champions.filter {$0 != answers[i]}
            // fill in the other 3 options randomly
            for _ in 1..<4 {
                let randNum = Int(arc4random_uniform(UInt32(champions.count)))
                randomChoices[i].append(champions.remove(at: randNum))
            }
        }
        return randomChoices
    }
    
    @IBAction func roundsPressed(_ sender: UIBarButtonItem) {
        let max = appDelegate.allChampions.count
        let alert = UIAlertController(title: "Enter the number of rounds you would like.",
        message: "Must be a number from 5 to \(max)",
        preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = "\(String(self.appDelegate.rounds))"
        }
        alert.addAction(UIAlertAction(title: "Enter", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
            let roundAmount = Int(textField.text!)
            if ((roundAmount == nil) || (roundAmount! < 5) || (roundAmount! > max)) {
                // set it to the default value
                self.appDelegate.rounds = 10
            } else {
                self.appDelegate.rounds = roundAmount!
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func unwind(unwindSegue: UIStoryboardSegue) {
        // doesn't need to do anything
    }
}
