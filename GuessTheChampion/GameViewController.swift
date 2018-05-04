//
//  GameViewController.swift
//  GuessTheChampion
//
//  Created by Jared Micheal Harding on 5/1/18.
//  Copyright © 2018 Jared Micheal Harding. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    // just a global reference to the appDelegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var imageView: UIImageView!
    // there might be buttons
    @IBOutlet weak var option1Button: UIButton?
    @IBOutlet weak var option2Button: UIButton?
    @IBOutlet weak var option3Button: UIButton?
    @IBOutlet weak var option4Button: UIButton?
    // or there might be a text box
    @IBOutlet weak var textField: UITextField?
    // but there is an enter button for sure
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // change the picture (and maybe the options) to match the specific round
        resetView()
    }
    
    func resetView() {
        let game = appDelegate.game!
        self.navigationItem.title = "Round \(game.getRound()+1) of \(appDelegate.rounds)"
        loadImage(ofChampion: game.getAnswer(), isBlank: true)
        if (game.getDifficulty() == .easy) {
            // set up the buttons for easy games
            loadOptionButtons(choices: game.getChoices())
        } else if (game.getDifficulty() == .hard) {
            textField!.backgroundColor = UIColor.clear
            textField!.text = ""
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadImage(ofChampion c: String, isBlank b: Bool) {
        var filename = "\(c)250"
        if (b) {
            filename.append("b")
        }
        imageView.image = UIImage(named: filename)
    }
    
    func loadOptionButtons(choices c: [String]) {
        var copy = c
        // put them in a random order
        
        let rand1 = Int(arc4random_uniform(UInt32(copy.count)))
        let string1 = copy.remove(at: rand1).replacingOccurrences(of: "_", with: " ").capitalized
        option1Button!.setTitle(string1, for: .normal)
        
        let rand2 = Int(arc4random_uniform(UInt32(copy.count)))
        let string2 = copy.remove(at: rand2).replacingOccurrences(of: "_", with: " ").capitalized
        option2Button!.setTitle(string2, for: .normal)
        
        let rand3 = Int(arc4random_uniform(UInt32(copy.count)))
        let string3 = copy.remove(at: rand3).replacingOccurrences(of: "_", with: " ").capitalized
        option3Button!.setTitle(string3, for: .normal)
        
        // there's only one choice for the last option
        let string4 = copy.remove(at: 0).replacingOccurrences(of: "_", with: " ").capitalized
        option4Button!.setTitle(string4, for: .normal)
    }
    
    func clearSelected() {
        option1Button!.isSelected = false
        option2Button!.isSelected = false
        option3Button!.isSelected = false
        option4Button!.isSelected = false
    }
    
    func clearButtonColor() {
        option1Button!.backgroundColor = UIColor.clear
        option2Button!.backgroundColor = UIColor.clear
        option3Button!.backgroundColor = UIColor.clear
        option4Button!.backgroundColor = UIColor.clear
    }
    
    func getSelectedOptionButton() -> UIButton? {
        if (option1Button!.isSelected) {
            return option1Button!
        } else if (option2Button!.isSelected) {
            return option2Button!
        } else if (option3Button!.isSelected) {
            return option3Button!
        } else if (option4Button!.isSelected) {
            return option4Button!
        } else {
            return nil
        }
    }
    
    @IBAction func optionPressed(_ sender: UIButton) {
        clearSelected()
        sender.isSelected = true
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        let game = appDelegate.game!
        if (game.getDifficulty() == .easy) {
            let selectedOption = getSelectedOptionButton()
            if (selectedOption == nil) {
                return
            }
            let text = selectedOption!.currentTitle!
            if (game.isCorrect(forString: text)) {
                game.incrementScore()
                selectedOption!.backgroundColor = UIColor.green
            } else {
                selectedOption!.backgroundColor = UIColor.red
            }
            selectedOption!.isSelected = false
        } else if (game.getDifficulty() == .hard) {
            let text = textField!.text!
            if (text == "") {
                return
            }
            if (game.isCorrect(forString: text)) {
                game.incrementScore()
                textField!.backgroundColor = UIColor.green
            } else {
                textField!.backgroundColor = UIColor.red
            }
        } else {
            // do nothing, just in case difficulty is neither for some reason
            return
        }
        loadImage(ofChampion: game.getAnswer(), isBlank: false)
        toggleSubmitNext()
    }
    
    func toggleSubmitNext() {
        nextButton.isEnabled = !(nextButton.isEnabled)
        submitButton.isEnabled = !(submitButton.isEnabled)
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        // reset for the next round
        toggleSubmitNext()
        let game = appDelegate.game!
        if (game.getDifficulty() == .easy) {
            clearSelected()
            clearButtonColor()
        }
        game.incrementRound()
        if (game.getRound() < appDelegate.rounds) {
            // there are still rounds left
            resetView()
        } else {
            // no more rounds
            let score = String(game.getScore())
            let rounds = String(appDelegate.rounds)
            let alert = UIAlertController(title: "You got \(score) out of \(rounds) correct",
                                          message: "\(game.getResponse())",
                                          preferredStyle: .alert)
            let alertActionMenu = UIAlertAction(title: "Main Menu",
                                                style: .default,
                                                handler: {
                action in
                // this goes back to the main menu
                self.performSegue(withIdentifier: "gameToTitle", sender: self)
            })
            alert.addAction(alertActionMenu)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
