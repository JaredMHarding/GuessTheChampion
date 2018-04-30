//
//  Champion.swift
//  GuessTheChampion
//
//  Created by Jared Micheal Harding on 4/30/18.
//  Copyright © 2018 Jared Micheal Harding. All rights reserved.
//

import Foundation
import UIKit

struct Champion {
    // instance variables
    var name: String
    var image: UIImage
    
    init(_ name: String,_ image: UIImage) {
        self.name = name
        self.image = image
    }
    
}
