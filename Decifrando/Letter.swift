//
//  Letter.swift
//  Decifrando
//
//  Created by Ana Luiza Ferrer on 03/11/16.
//
//

import Foundation
import SpriteKit

class Letter: SKLabelNode {
    
    static let kLetterNodeName = "movable"
    
    init (letter: Character) {
        
        super.init(fontNamed: "OpenDyslexic-Bold")
        self.text = "\(letter)"
        self.fontSize = 100
        self.fontColor = SKColor.black
        self.name = Letter.kLetterNodeName
        //self.verticalAlignmentMode = .center
        
    }
    
    override init() {
        
        super.init()
        self.fontName = "OpenDyslexic-Bold"
        self.text = randomString(length: 1)
        self.fontSize = 100
        self.fontColor = SKColor.black
        self.name = Letter.kLetterNodeName
        //self.verticalAlignmentMode = .center

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyz"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
}
