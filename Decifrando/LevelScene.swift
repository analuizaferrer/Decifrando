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
        
    }
    
   
    
}
