//
//  Level.swift
//  Decifrando
//
//  Created by Ana Luiza Ferrer on 07/11/16.
//
//

import Foundation

class Level {
    
    var word: String!
    var image: String!
    var category: String!
    var completed: Bool!
    
    init(word: String, image: String, category: String, completed: Bool) {
        self.word = word
        self.image = image
        self.category = category
        self.completed = completed
    }

}
