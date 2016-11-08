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
    
    var correctWord: String!
    var boxArray: [Box]!
    var lettersArray: [Letter]!
    
    var background: SKSpriteNode!
    
    var selectedNode: Letter?
    
    var letterPreviousPosition: CGPoint!
    
    override func didMove(to view: SKView) {
        
        let selectedLevel: Int = AppData.sharedInstance.selectedLevelIndex
        correctWord = AppData.sharedInstance.levelsList[selectedLevel].word
        
        background = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: self.size.width, height: self.size.height))
        self.background.name = "background"
        self.background.anchorPoint = CGPoint.zero
        self.addChild(background)
        
        boxArray = []
        
        for letter in correctWord.characters {
            
            boxArray.append(Box(letter: letter))
            
        }
        
        var i = 0
        for box in boxArray {
            
            let offsetFraction = (CGFloat(i) + 1.0)/(CGFloat(boxArray.count) + 1.0)
            
            box.position = CGPoint(x: size.width * offsetFraction, y: size.height/2)
            addChild(box)
            
            i = i + 1
            
        }
        
        lettersArray = []
        
        for letter in correctWord.characters {
            
            lettersArray.append(Letter(letter: letter))
    
        }
        
        for _ in 0 ..< 10-correctWord.characters.count {
        
            lettersArray.append(Letter())
        
        }
        
        lettersArray.shuffle()
        
        var j = 0
        for letter in lettersArray {
            
            let offsetFraction = (CGFloat(j) + 1.0)/(CGFloat(lettersArray.count) + 1.0)
            
            letter.position = CGPoint(x: size.width * offsetFraction, y: size.height/4)
            letter.zPosition = 20
            background.addChild(letter)
            j = j + 1
            
        }
        
        let backLabel = SKLabelNode(fontNamed: "Arial Rounded MT Bold")
        backLabel.text = "Back"
        backLabel.fontSize = 40
        backLabel.fontColor = SKColor.black
        backLabel.position = CGPoint(x: size.width/8, y: 9*size.height/10)
        addChild(backLabel)
        backLabel.name = "Back"
        
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
            
            if !(selectedNode?.isEqual(touchedNode))! && selectedNode != nil{
                selectedNode?.removeAllActions()
                selectedNode?.run(SKAction.rotate(toAngle: 0.0, duration: 0.1))
                
                selectedNode = touchedNode as? Letter
            }
        }
        
        if touchedNode.name == "Back" {
            
            print("back")
            
            self.returnToMenu()
            
        }
        
    }
    
    func panForTranslation(translation: CGPoint) {
        let position = selectedNode?.position
        
        if selectedNode?.name != nil && selectedNode?.name! == Letter.kLetterNodeName {
            selectedNode?.position = CGPoint(x: (position?.x)! + translation.x, y: (position?.y)! + translation.y)
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if touches.first != nil {
        let touch = touches.first!
        let positionInScene = touch.location(in: self)
        let previousPosition = touch.previousLocation(in: self)
        let translation = CGPoint(x: positionInScene.x - previousPosition.x, y: positionInScene.y - previousPosition.y)
            
                panForTranslation(translation: translation)

        }
    
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
     
        letterIsInsideBox()
        
        if didWin() {
            
            levelWon()
            
        }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        letterIsInsideBox()
        
        if didWin() {
            print("você ganhou!!")
        }
        
    }
    
    func letterIsInsideBox() {
        
        var correctBox = false
        
        for box in boxArray {
            
            let xMin = box.position.x - box.size.width/2
            let xMax = box.position.x + box.size.width/2
            let yMin = box.position.y - box.anchorPoint.y*box.size.height
            let yMax = box.position.y + (1-box.anchorPoint.y)*box.size.height
            
            if (selectedNode?.position.x)! > xMin && (selectedNode?.position.x)! < xMax && (selectedNode?.position.y)! > yMin && (selectedNode?.position.y)! < yMax {
                
                if selectedNode?.text?.characters.first == box.boxLetter {
                    
                    selectedNode?.position.x = box.position.x
                    selectedNode?.position.y = box.position.y - (selectedNode?.fontSize)!/4
                    
                    correctBox = true
                    box.isFull = true
                    
                } else {
                    
                    selectedNode?.position = letterPreviousPosition
                    
                }
            }
        }
        
        if !correctBox {
            
            selectedNode?.position = letterPreviousPosition
            
        }
    }
    
    func didWin()->Bool {
        
        for box in boxArray {
            if !box.isFull {
                return false
            }
        }
        
        return true
    }
    
    func levelWon () {
        
        DAO().updateLevelCompleted(levelNumber: AppData.sharedInstance.selectedLevelIndex + 1)
        AppData.sharedInstance.levelsList[AppData.sharedInstance.selectedLevelIndex].completed = true
        
        let reveal = SKTransition.fade(withDuration: 1)
        let levelCompletedScene = LevelCompletedScene(size: self.size)
        self.view?.presentScene(levelCompletedScene, transition: reveal)
        
    }
    
    func returnToMenu() {
        let reveal = SKTransition.fade(withDuration: 1.0)
        let scene = CategoryScene(size: size)
        self.view?.presentScene(scene, transition:reveal)
    }
    
}
