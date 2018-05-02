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
        if (sender.tag == 1) {
            // Easy was selected
            performSegue(withIdentifier: "titleToEasyGame", sender: self)
        } else if (sender.tag == 2) {
            // Hard was selected
            performSegue(withIdentifier: "titleToHardGame", sender: self)
        }
    }
    
    @IBAction func unwindFunction(unwindSegue: UIStoryboardSegue) {
        // doesn't need to do anything
    }
}

