//
//  LevelCompletedScene.swift
//  Decifrando
//
//  Created by Ana Luiza Ferrer on 08/11/16.
//
//

import Foundation
import SpriteKit

class LevelCompletedScene: SKScene {
    
    var background: SKSpriteNode!
    
    override init(size: CGSize) {
        
        super.init(size: size)
        
        background = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: self.size.width, height: self.size.height))
        self.background.name = "background"
        self.background.anchorPoint = CGPoint.zero
        self.addChild(background)
        
        let menuLabel = SKLabelNode(fontNamed: "Riffic")
        menuLabel.text = "Voltar para o Menu"
        menuLabel.fontSize = 40
        menuLabel.fontColor = SKColor.black
        menuLabel.position = CGPoint(x: size.width/2, y: 2*size.height/3)
        addChild(menuLabel)
        menuLabel.name = "Menu"
        
        let nextLabel = SKLabelNode(fontNamed: "Riffic")
        nextLabel.text = "Próxima palavra"
        nextLabel.fontSize = 40
        nextLabel.fontColor = SKColor.black
        nextLabel.position = CGPoint(x: size.width/2, y: size.height/3)
        addChild(nextLabel)
        nextLabel.name = "Next"
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        let node = self.atPoint(touchLocation)
        
        if node.name == "Menu" {
            self.returnToMenu()
        }
        
        if node.name == "Next" {
            self.nextLevel()
        }
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func returnToMenu() {
        let reveal = SKTransition.fade(withDuration: 1.0)
        let scene = CategoryScene(size: size)
        self.view?.presentScene(scene, transition:reveal)
    }
    
    func nextLevel() {
        
        AppData.sharedInstance.selectedLevelIndex = AppData.sharedInstance.selectedLevelIndex + 1
        
        let reveal = SKTransition.fade(withDuration: 1.0)
        let scene = LevelScene(size: size)
        self.view?.presentScene(scene, transition:reveal)
    }
    
}
