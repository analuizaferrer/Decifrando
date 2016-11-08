//
//  Level.swift
//  Decifrando
//
//  Created by Ana Luiza Ferrer on 07/11/16.
//
//

import Foundation

class Level {
    
    var levelNumber: Int!
    var word: String!
    var image: String!
    var category: String!
    var completed: Bool!
    
    init(levelNumber: Int, word: String, image: String, category: String, completed: Bool) {
        self.levelNumber = levelNumber
        self.word = word
        self.image = image
        self.category = category
        self.completed = completed
    }

}
