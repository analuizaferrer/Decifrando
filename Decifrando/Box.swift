//
//  Box.swift
//  Decifrando
//
//  Created by Ana Luiza Ferrer on 03/11/16.
//
//

import Foundation
import SpriteKit

private let boxWidth = 100

class Box: SKSpriteNode {
    
    let boxLetter: Character!
    var isFull: Bool!
    
    init (letter: Character) {
        
        var size: CGSize
        var anchorPoint: CGPoint
        
        self.isFull = false
        self.boxLetter = letter
        
        if letter == "b" || letter == "d" || letter == "f" || letter == "h" || letter == "k" || letter == "l" || letter == "t" {
            
            size = CGSize(width: boxWidth, height: 140)
            anchorPoint = CGPoint(x: 0.5, y: 40/size.height)
            
        } else if letter == "g" || letter == "j" || letter == "p" || letter == "q" || letter == "y" {
            
            size = CGSize(width: boxWidth, height: 140)
            anchorPoint = CGPoint(x: 0.5, y: 1-(60/size.height))
            
        } else {
            
            size = CGSize(width: boxWidth, height: boxWidth)
            anchorPoint = CGPoint(x: 0.5, y: 0.4)
            
        }
        
        super.init(texture: SKTexture(imageNamed:"caseWithLetter"), color: UIColor.red, size: size)
        self.zPosition = 1
        self.anchorPoint = anchorPoint
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
