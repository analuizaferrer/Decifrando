//
//  CategoryScene.swift
//  Decifrando
//
//  Created by Ana Luiza Ferrer on 03/11/16.
//
//

import Foundation
import SpriteKit

class CategoryScene: SKScene {
    
    var background: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        background = SKSpriteNode(color: UIColor.green, size: CGSize(width: self.size.width, height: self.size.height))
        self.background.name = "background"
        self.background.anchorPoint = CGPoint.zero
        self.addChild(background)
        
        let levelLabel = SKLabelNode(fontNamed: "Arial Rounded MT Bold")
        levelLabel.text = "1"
        levelLabel.fontSize = 40
        levelLabel.fontColor = SKColor.black
        levelLabel.position = CGPoint(x: size.width/2, y: size.height/8)
        addChild(levelLabel)
        levelLabel.name = "Level 1"
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        let node = self.atPoint(touchLocation)
        
        if node.name == "Level 1" {
            self.startGame()
        }
        
    }
    
    func startGame() {
        let reveal = SKTransition.fade(withDuration: 1.0)
        let scene = LevelScene(size: size)
        self.view?.presentScene(scene, transition:reveal)
    }
    
}
