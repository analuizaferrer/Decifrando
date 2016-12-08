//
//  LevelScene.swift
//  Decifrando
//
//  Created by Ana Luiza Ferrer on 03/11/16.
//
//

import Foundation
import SpriteKit
import AVFoundation

class LevelScene: SKScene, SKPhysicsContactDelegate {
    
    var correctWordPT: String!
    var correctWordEN: String!
    var boxArray: [Box]!
    var lettersArray: [Letter]!
    var background: SKSpriteNode!
    var selectedNode: Letter?
    var letterPreviousPosition: CGPoint!
    var backLabel: SKLabelNode!
    var nextLabel: SKLabelNode!
    var imageNode: SKSpriteNode!
    var win: Bool!
    
    override func didMove(to view: SKView) {
        
        let selectedLevel: Int = AppData.sharedInstance.selectedLevelIndex
        
        correctWordPT = AppData.sharedInstance.levelsList[selectedLevel].word
        correctWordEN = AppData.sharedInstance.levelsList[selectedLevel].image
        
        background = SKSpriteNode(imageNamed:"backgroundLetras")
        background.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.background.name = "background"
        self.background.anchorPoint = CGPoint.zero
        self.background.zPosition = 0
        self.addChild(background)
        
        self.createLevelLabels()
        
        boxArray = []
        
        for letter in correctWordPT.characters {
            
            boxArray.append(Box(letter: letter))
            
        }
        
        var i = 0
        for box in boxArray {
            
            let offsetFraction = (CGFloat(i) + 1.0)/(CGFloat(boxArray.count) + 1.0)
            
            box.position = CGPoint(x: size.width * offsetFraction, y: size.height/3)
            box.zPosition = 2
            addChild(box)
            
            i = i + 1
            
        }
        
        lettersArray = []
        
        for letter in correctWordPT.characters {
            
            lettersArray.append(Letter(letter: letter))
            
        }
        
        for _ in 0 ..< 10-correctWordPT.characters.count {
            
            lettersArray.append(Letter())
            
        }
        
        lettersArray.shuffle()
        
        var j = 0
        for letter in lettersArray {
            
            let offsetFraction = (CGFloat(j) + 1.0)/(CGFloat(lettersArray.count) + 1.0)
            
            letter.position = CGPoint(x: size.width * offsetFraction, y: size.height/8)
            letter.zPosition = 3
            background.addChild(letter)
            j = j + 1
            
        }
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        self.win = false
        
    }
    
    func createLevelLabels() {
        
        imageNode = SKSpriteNode(imageNamed: AppData.sharedInstance.levelsList[AppData.sharedInstance.selectedLevelIndex].image)
        imageNode.position = CGPoint(x: size.width/2, y: 2*size.height/3)
        imageNode.size = CGSize(width: size.width/3, height: size.width/3)
        imageNode.zPosition = 1
        self.addChild(imageNode)
        
        self.nextLabel = SKLabelNode(fontNamed: "Riffic")
        self.nextLabel.text = "Próxima palavra"
        self.nextLabel.fontSize = 40
        self.nextLabel.fontColor = SKColor.black
        self.nextLabel.name = "Next"
        self.nextLabel.position = CGPoint(x: size.width/2, y: size.height/50)
        self.nextLabel.isHidden = true
        self.nextLabel.zPosition = 1
        self.background.addChild(nextLabel)
        
        self.backLabel = SKLabelNode(fontNamed: "Riffic")
        self.backLabel.text = "Voltar"
        self.backLabel.fontSize = 40
        self.backLabel.fontColor = SKColor.black
        self.backLabel.position = CGPoint(x: size.width/8, y: 9*size.height/10)
        self.backLabel.name = "Back"
        self.backLabel.zPosition = 1
        self.background.addChild(backLabel)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first!
        let positionInScene = touch.location(in: self)
        
        selectNodeForTouch(touchLocation: positionInScene)
        
    }
    
    func selectNodeForTouch(touchLocation: CGPoint) {
        
        selectedNode = Letter()
        
        let touchedNode = self.atPoint(touchLocation)
        letterPreviousPosition = touchedNode.position
        
        if touchedNode is Letter {
            
            if !(selectedNode?.isEqual(touchedNode))! && selectedNode != nil {
                
                selectedNode?.removeAllActions()
                selectedNode?.run(SKAction.rotate(toAngle: 0.0, duration: 0.1))
                
                selectedNode = touchedNode as? Letter
                
                let sound = "\(selectedNode!.text!).mp3"
                
                run(SKAction.playSoundFileNamed(sound, waitForCompletion: false))

            }
            
        } else if touchedNode.name == "Back" || touchedNode.name == "Next" {
            
            run(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: false))
            self.returnToCategoryScene()
            
        } else if touchedNode.name == "Back to menu" {
            
            run(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: false))
            self.returnToMenuScene()
        }
    }
    
    func panForTranslation(translation: CGPoint) {
        
        let position = selectedNode?.position
        
        if selectedNode?.name != nil && selectedNode?.name! == Letter.kLetterNodeName && (selectedNode?.movable)! {
            
            let newPosition = CGPoint(x: (position?.x)! + translation.x, y: (position?.y)! + translation.y)
            
            if newPosition.x - (selectedNode?.frame.width)!/2 > 0 && newPosition.x + (selectedNode?.frame.width)!/2 < self.frame.width && newPosition.y - (selectedNode?.frame.height)!/2 > 0 && newPosition.y + (selectedNode?.frame.width)!/2 < self.frame.height {
            
                selectedNode?.position = newPosition
            
            }
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if touches.first != nil {
            
            let touch = touches.first!
            let positionInScene = touch.location(in: self)
            let previousPosition = touch.previousLocation(in: self)
            let translation = CGPoint(x: positionInScene.x - previousPosition.x, y: positionInScene.y - previousPosition.y)
            
            panForTranslation(translation: translation)
            
            highlightBox()
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        letterIsInsideBox()
        
        if didWin() && self.win == false {
            
            self.win = true
            levelComplete()
            
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        letterIsInsideBox()
        
        if didWin() && self.win == false {
            
            self.win = true
            levelComplete()
            
        }
    }
    
    func letterIsInsideBox() {
        
        for box in boxArray {
            
            let xMin = box.position.x - box.size.width/2
            let xMax = box.position.x + box.size.width/2
            let yMin = box.position.y - box.anchorPoint.y*box.size.height - 50
            let yMax = box.position.y + (1-box.anchorPoint.y)*box.size.height
            
            if (selectedNode?.position.x)! > xMin && (selectedNode?.position.x)! < xMax && (selectedNode?.position.y)! > yMin && (selectedNode?.position.y)! < yMax {
                
                if selectedNode?.text?.characters.first == box.boxLetter && !box.isFull {
                    
                    selectedNode?.position.x = box.position.x
                    selectedNode?.position.y = box.position.y - (selectedNode?.fontSize)!/4
                    
                    box.isFull = true
                    selectedNode?.movable = false
                    
                } else {
                    
                    selectedNode?.position = letterPreviousPosition
                    if !box.isFull {
                        box.texture = SKTexture(imageNamed: "caseWithLetter")
                    }
                }
            }
        }
    }
    
    func highlightBox() {
        
        for box in boxArray {
            
            let xMin = box.position.x - box.size.width/2
            let xMax = box.position.x + box.size.width/2
            let yMin = box.position.y - box.anchorPoint.y*box.size.height - 50
            let yMax = box.position.y + (1-box.anchorPoint.y)*box.size.height
            
            if (selectedNode?.position.x)! > xMin && (selectedNode?.position.x)! < xMax && (selectedNode?.position.y)! > yMin && (selectedNode?.position.y)! < yMax {
                
                box.texture = SKTexture(imageNamed: "case")
                
            }
                
            else if !box.isFull {
                
                box.texture = SKTexture(imageNamed: "caseWithLetter")
                
            }
        }
        
    }
    
    func didWin()->Bool {
        
        for box in boxArray {
            if !box.isFull {
                return false
            }
        }
        
        if AppData.sharedInstance.selectedLevelIndex == AppData.sharedInstance.levelsList.count - 1 {
            
            let victory = SKSpriteNode(imageNamed: "win")
            victory.zPosition = 4
            victory.position = CGPoint(x: size.width/2, y: size.height/2)
            background.addChild(victory)
            
            
            let backToMenu = SKLabelNode(fontNamed: "Riffic")
            backToMenu.text = "Voltar para o menu"
            backToMenu.name = "Back to menu"
            backToMenu.fontColor = SKColor.black
            backToMenu.fontSize = 40
            backToMenu.zPosition = 5
            backToMenu.position = CGPoint(x: size.width/2, y: size.height/2-100)
            background.addChild(backToMenu)
            
        }
        
        return true
    }
    
    func levelComplete () {
        
        AppData.sharedInstance.levelsList[AppData.sharedInstance.selectedLevelIndex].completed = true
        _ = DAO().updateLevelCompleted(category: AppData.sharedInstance.levelsList[0].category)
        
        
        if AppData.sharedInstance.selectedLevelIndex < AppData.sharedInstance.levelsList.count - 1 {
            
            self.nextLabel.isHidden = false
            self.backLabel.isHidden = true
            
        }
        
        playAnimalSound()
        
        playAnimalNameSound()
        
//        run(SKAction.repeatForever(
//            SKAction.sequence([
//                SKAction.run(addParticles),
//                SKAction.wait(forDuration: 1.0)
//                ])
//        ))
        
    }
    
    func addParticles() {
        
        let path = Bundle.main.path(forResource: "HeartParticle", ofType: "sks")
        let particle = NSKeyedUnarchiver.unarchiveObject(withFile: path!) as! SKEmitterNode
        
        particle.targetNode = self.scene
        particle.position.x = imageNode.position.x
        particle.position.y = imageNode.position.y + imageNode.size.height/2
        particle.xScale = 0.3
        particle.yScale = 0.3
        
        particle.numParticlesToEmit = 10
        
        self.addChild(particle)
        
    }
    
    func playAnimalSound() {
        
        let sound = "\(correctWordPT!).mp3"
        
        run(SKAction.playSoundFileNamed(sound, waitForCompletion: false))
        
    }
    
    func playAnimalNameSound() {
    
        let sound = "\(correctWordEN!).mp3"
        
        run(SKAction.playSoundFileNamed(sound, waitForCompletion: false))

    }
    
    func returnToCategoryScene() {
        
        let reveal = SKTransition.fade(withDuration: 1.0)
        let scene = CategoryScene(size: size)
        self.view?.presentScene(scene, transition:reveal)
        
    }
    
    func returnToMenuScene() {
        
        let reveal = SKTransition.fade(withDuration: 1.0)
        let scene = MenuScene(size: size)
        self.view?.presentScene(scene, transition:reveal)
    }
}

