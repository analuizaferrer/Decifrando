//
//  Box.swift
//  Decifrando
//
//  Created by Ana Luiza Ferrer on 03/11/16.
//
//

import Foundation
import SpriteKit

class Box: SKSpriteNode {
    
    init (letter: Character) {
        
        var size: CGSize
        
        var anchorPoint: CGPoint
        
        if letter == "b" || letter == "d" || letter == "f" || letter == "h" || letter == "k" || letter == "l" || letter == "t" {
            
            size = CGSize(width: 30, height: 60)
            
            anchorPoint = CGPoint(x: 0.5, y: 0.25)
            
        }
        
        else if letter == "g" || letter == "j" || letter == "p" || letter == "q" || letter == "y" {
            
            size = CGSize(width: 30, height: 60)
            
            anchorPoint = CGPoint(x: 0.5, y: 0.75)
            
        }
        
        else {
            
            size = CGSize(width: 30, height: 30)
            
            anchorPoint = CGPoint(x: 0.5, y: 0.5)
            
        }
        
        super.init(texture: nil, color: UIColor.red, size: size)
        self.anchorPoint = anchorPoint
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
