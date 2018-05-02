//
//  GuessTheChampion.swift
//  GuessTheChampion
//
//  Created by Jared Micheal Harding on 4/30/18.
//  Copyright © 2018 Jared Micheal Harding. All rights reserved.
//

import Foundation

public struct GuessTheChampion {
    
    public enum difficulty {
        case easy, hard
    }
    
    // instance variables
    private var score: Int
    private var answers: [String]
    private var choices: [[String]]?
    private var difficulty: difficulty
    
    // in easy mode you have choices
    init(answers: [String], choices: [[String]]) {
        self.score = 0
        self.answers = answers
        self.choices = choices
        self.difficulty = .easy
    }
    
    // in hard mode you don't have choices, it's just a text box
    init(answers: [String]) {
        self.score = 0
        self.answers = answers
        self.choices = nil
        self.difficulty = .hard
    }
    
    public func isCorrect(forRound r: Int, forString s: String) -> Bool {
        return answers[r] == s
    }
    
    public func incrementScore() {
        score += 1
    }
    
    
}
