//
//  LevelScene.swift
//  Decifrando
//
//  Created by Ana Luiza Ferrer on 03/11/16.
//
//

import Foundation
import SpriteKit

class LevelScene: SKScene {
    
    let correctWord = "pato"
    var boxArray: [Box]!
    var lettersArray: [SKLabelNode]!
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor.blue
        
        boxArray = []
        
        for letter in correctWord.characters {
            
            boxArray.append(Box(letter: letter))
            
        }
        
        var x: CGFloat = 30
        for box in boxArray {
            
            box.position = CGPoint(x: x, y: size.height/2)
            addChild(box)
            
            x = x + box.size.width + 10
        }
        
        lettersArray = []
        
        for letter in correctWord.characters {
            
            lettersArray.append(Letter(letter: letter))
            
        }
        
        for _ in 0 ..< 10-correctWord.characters.count {
        
            lettersArray.append(Letter())
        
        }
        
        var x2: CGFloat = 30
        for letter in lettersArray {
            
            letter.position = CGPoint(x: x2, y: size.height/4)
            addChild(letter)
            
            x2 = x2 + 50
            
        }
        
    }
    
}
