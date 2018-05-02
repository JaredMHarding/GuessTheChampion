//
//  GameViewController.swift
//  GuessTheChampion
//
//  Created by Jared Micheal Harding on 5/1/18.
//  Copyright © 2018 Jared Micheal Harding. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // change the picture (and maybe the options) to match the specific round
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let game = appDelegate.game!
        loadImage(ofChampion: game.getAnswer(), isBlank: true)
        if (game.getDifficulty() == .easy) {
            // set up the buttons for the easy games
            
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
