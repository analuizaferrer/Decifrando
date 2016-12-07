//
//  ThankYouScene.swift
//  Decifrando
//
//  Created by Ana Luiza Ferrer on 07/12/16.
//
//

import Foundation
import SpriteKit

class ThankYouScene: SKScene {
    
    var background: SKSpriteNode!
    var backButton: SKSpriteNode!
    var thankYou: SKLabelNode!
    
    var lastPos : CGPoint!
    
    override func didMove(to view: SKView) {
        
        let s = getAspectFitSize(toX: 50, toY: 50)
        background = SKSpriteNode(imageNamed: "backgroundLetras")
        self.addChild(background)
        background.position = CGPoint(x: size.width/2,y: s.height/2)

        
        self.createThankYouLabels()
        
    }
    
    func createThankYouLabels() {
        
        let s = getAspectFitSize(toX: 50, toY: 50)
        backButton = SKSpriteNode(imageNamed: "backButton")
        backButton.size = s
        backButton.zPosition = 1
        backButton.position = CGPoint(x: size.width/12, y: 11*size.height/12)
        backButton.name = "Back"
        
        self.addChild(backButton)
        
        thankYou = SKLabelNode(fontNamed: "Riffic")
        self.thankYou.fontSize = 75
        self.thankYou.fontColor = SKColor.white
        self.thankYou.text = "Créditos e Agradecimentos"
        self.thankYou.position = CGPoint(x: 50/2, y: size.height - 200)
        self.thankYou.zPosition = 1
        background.addChild(thankYou)
        
        let thankYouMessages = ["Alena Miklos", "Amanda Manso", "Our Lady of Mercy School", "BEPiD", "Thais Lima", "Nelson Donato", "Jessé Cerqueira", "Thiago De Angelis", "coruja - http://audiosoundclips.com/audio-sound-clips-effects-animal/", "gato - https://www.freesound.org/people/tuberatanka/sounds/110011/", "cavalo - https://www.freesound.org/people/foxen10/sounds/149024/", "papagaio - http://www.sound-effects-hunter.com/parrot-sounds/", "baleia - https://www.freesound.org/people/Tritus/sounds/186899/"]
        
        var n = 2
        
        for message in thankYouMessages {
            
            let label = SKLabelNode(fontNamed: "Riffic")
            label.fontSize = 50
            label.fontColor = SKColor.white
            label.text = message
            label.position = CGPoint(x: 50/2, y: Int(size.height) - n*Int(background.size.height)/(thankYouMessages.count+2))
            label.zPosition = 10
            background.addChild(label)
            
            n = n+1
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        lastPos = touches.first!.location(in: self)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let p = touches.first!.location(in: self)
        let dist = CGPoint(x: p.x-lastPos.x,y: p.y-lastPos.y)
        let bp = background.position
        background.position.y = max(min(background.size.height/2,bp.y+dist.y),size.height-background.size.height/2)
        lastPos = p
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        let node = self.atPoint(touchLocation)
        
        if node.name == "Back" {
            
            run(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: false))
            
            let reveal = SKTransition.fade(withDuration: 1.0)
            let scene = HomeScene(size: size)
            self.view?.presentScene(scene, transition:reveal)
            
        }
    }
}

