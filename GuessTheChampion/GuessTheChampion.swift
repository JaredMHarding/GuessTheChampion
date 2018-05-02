//
//  GuessTheChampion.swift
//  GuessTheChampion
//
//  Created by Jared Micheal Harding on 4/30/18.
//  Copyright © 2018 Jared Micheal Harding. All rights reserved.
//

import Foundation

public class GuessTheChampion {
    
    public enum difficulty {
        case easy, hard
    }
    
    // instance variables
    private var score: Int
    private var roundCounter: Int
    private var answers: [String]
    private var choices: [[String]]?
    private var difficulty: difficulty
    
    // in easy mode you have choices
    init(answers: [String], choices: [[String]]) {
        self.score = 0
        self.roundCounter = 0
        self.answers = answers
        self.choices = choices
        self.difficulty = .easy
    }
    
    // in hard mode you don't have choices, it's just a text box
    init(answers: [String]) {
        self.score = 0
        self.roundCounter = 0
        self.answers = answers
        self.choices = nil
        self.difficulty = .hard
    }
    
    public func isCorrect(forString s: String) -> Bool {
        // sanitize the string
        let cleanString = s.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "_").lowercased()
        return (answers[roundCounter] == cleanString)
    }
    
    public func incrementScore() {
        score += 1
    }
    
    public func incrementRound() {
        roundCounter += 1
    }
    
    public func getScore() -> Int {
        return score
    }
    
    public func getRound() -> Int {
        return roundCounter
    }
    
    public func getAnswer() -> String {
        return answers[roundCounter]
    }
    
    public func getDifficulty() -> difficulty {
        return self.difficulty
    }
}
