//
//  HomeScene.swift
//  Decifrando
//
//  Created by Helena Leitão on 16/11/16.
//
//

import Foundation
import SpriteKit

class HomeScene: SKScene {

    var background: SKSpriteNode!
    var start: SKLabelNode!
    var thankYou: SKLabelNode!
    var settings: SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        background = SKSpriteNode(imageNamed:"background")
        background.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        background.zPosition = 0
        self.background.name = "background"
        self.background.anchorPoint = CGPoint.zero
        self.addChild(background)
        
        self.createHomeLabels()
        
    }
    
    func createHomeLabels() {
    
        start = SKLabelNode(fontNamed: "Riffic")
        self.start.fontSize = 75
        self.start.fontColor = SKColor.white
        self.start.text = "início"
        self.start.name = "Start"
        self.start.position = CGPoint(x: size.width/2, y: size.height/2 - 250)
            self.start.zPosition = 1
        background.addChild(start)
         
        thankYou = SKLabelNode(fontNamed: "Riffic")
        self.thankYou.fontSize = 75
        self.thankYou.fontColor = SKColor.white
        self.thankYou.text = "agradecimentos"
        self.thankYou.name = "Thank You"
        self.thankYou.position = CGPoint(x: size.width/2, y: size.height/2 - 350)
        self.thankYou.zPosition = 1
        background.addChild(thankYou)
        
//        settings = SKLabelNode(fontNamed: "Riffic")
//        self.settings.fontSize = 30
//        self.settings.fontColor = SKColor.gray
//        self.settings.text = "Configurações"
//        self.settings.name = "Settings"
//        self.settings.position = CGPoint(x: size.width - 100, y: size.height - 70)
//        background.addChild(settings)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        let node = self.atPoint(touchLocation)
        
        if node.name == "Start" {
            
            self.start.fontColor = SKColor.black
            
            run(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: false))
            
            let reveal = SKTransition.fade(withDuration: 1.0)
            let scene = MenuScene(size: size)
            self.view?.presentScene(scene, transition:reveal)
           
        } else if node.name == "Thank You" {
            
            run(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: false))
            
            let reveal = SKTransition.fade(withDuration: 1.0)
            let scene = ThankYouScene(size: size)
            self.view?.presentScene(scene, transition:reveal)
            
        } else if node.name == "Settings" {
            
            
            
        }
    }
}
