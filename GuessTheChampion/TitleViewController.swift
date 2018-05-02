//
//  TitleViewController.swift
//  GuessTheChampion
//
//  Created by Jared Micheal Harding on 4/30/18.
//  Copyright © 2018 Jared Micheal Harding. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startGame(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if (sender.tag == 1) {
            // Easy was selected
            
            performSegue(withIdentifier: "titleToEasyGame", sender: self)
        } else if (sender.tag == 2) {
            // Hard was selected
            appDelegate.game = GuessTheChampion(answers: getRandomChampionsHard(amount: appDelegate.rounds))
            performSegue(withIdentifier: "titleToHardGame", sender: self)
        }
    }
    
    func getRandomChampionsHard(amount: Int) -> [String] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var champions = appDelegate.champions
        var randomChampions: [String] = []
        for _ in 0..<amount {
            let randNum = Int(arc4random_uniform(UInt32(champions.count)))
            // removing it from the champion list ensures we get unique champions for each round
            randomChampions.append(champions.remove(at: randNum))
        }
        return randomChampions
    }
    
    @IBAction func unwindFunction(unwindSegue: UIStoryboardSegue) {
        // doesn't need to do anything
    }
}
