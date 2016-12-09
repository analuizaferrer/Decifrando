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
    var transparentBg: SKSpriteNode!
    var backButton: SKSpriteNode!
    
    var lastPos : CGPoint!
    
    override func didMove(to view: SKView) {
        
        //let s = getAspectFitSize(toX: 50, toY: 50)
        
        background = SKSpriteNode(imageNamed: "backgroundLetras")
        background.zPosition = 0
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.addChild(background)
        
        transparentBg = SKSpriteNode(color: UIColor.clear, size: CGSize(width: self.size.width, height: 2300))
        transparentBg.zPosition = 1
        self.addChild(transparentBg)
        transparentBg.position = CGPoint(x: size.width/2,y: 0)

        
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
        
        var y: CGFloat = 125
        
        let thankYouLabel = SKLabelNode(fontNamed: "Riffic")
        thankYouLabel.fontSize = 75
        thankYouLabel.fontColor = SKColor.black
        thankYouLabel.text = "Agradecimentos"
        thankYouLabel.position = CGPoint(x: 50/2, y: size.height - y)
        thankYouLabel.zPosition = 1
        transparentBg.addChild(thankYouLabel)
        
        y = y + 125
        
        let thankYouMessages = ["Alena Miklos", "Amanda Manso", "BEPiD Rio", "Jessé Cerqueira", "Nelson Donato", "Our Lady of Mercy School", "Thais Lima", "Thiago De Angelis"]
        
        for message in thankYouMessages {
            
            let label = SKLabelNode(fontNamed: "Riffic")
            label.fontSize = 50
            label.fontColor = SKColor.black
            label.text = message
            label.position = CGPoint(x: 50/2, y: size.height - (y))
            label.zPosition = 10
            transparentBg.addChild(label)
            
            y = y + 100
            
        }
        
        y = y + 200
        
        let creditsLabel = SKLabelNode(fontNamed: "Riffic")
        creditsLabel.fontSize = 75
        creditsLabel.fontColor = SKColor.black
        creditsLabel.text = "Créditos"
        creditsLabel.position = CGPoint(x: 50/2, y: size.height - y)
        creditsLabel.zPosition = 1
        transparentBg.addChild(creditsLabel)
        
        y = y + 125
        
        let creditsMessages = ["som do gato:", "som do cavalo:", "som da coruja:", "som da baleia:", "som do papagaio:"]
        let creditLinks = ["https://www.freesound.org/people/tuberatanka/sounds/110011/", "https://www.freesound.org/people/foxen10/sounds/149024/", "http://audiosoundclips.com/audio-sound-clips-effects-animal/", "https://www.freesound.org/people/Tritus/sounds/186899/", "http://www.sound-effects-hunter.com/parrot-sounds/"]
        
        var i = 0
        
        for message in creditsMessages {
            
            let label = SKLabelNode(fontNamed: "Riffic")
            label.fontSize = 50
            label.fontColor = SKColor.black
            label.text = message
            label.position = CGPoint(x: 50/2, y: size.height - (y))
            label.zPosition = 10
            transparentBg.addChild(label)
            
            y = y + 50
            
            let link = SKLabelNode(fontNamed: "Riffic")
            link.fontSize = 30
            link.fontColor = SKColor.black
            link.text = creditLinks[i]
            link.position = CGPoint(x: 50/2, y: size.height - (y))
            link.zPosition = 10
            transparentBg.addChild(link)
            
            i = i + 1
            
            y = y + 100

            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        lastPos = touches.first!.location(in: self)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let p = touches.first!.location(in: self)
        let dist = CGPoint(x: p.x-lastPos.x,y: p.y-lastPos.y)
        let bp = transparentBg.position
        transparentBg.position.y = max(min(transparentBg.size.height/2,bp.y+dist.y),size.height-transparentBg.size.height/2)
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

