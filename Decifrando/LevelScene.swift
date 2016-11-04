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
    
    let correctWord = "gato"
    var boxArray: [Box]!
    var lettersArray: [Letter]!
    
    var background: SKSpriteNode!
    
    var selectedNode: Letter?
    
    override func didMove(to view: SKView) {
        
        background = SKSpriteNode(color: UIColor.blue, size: CGSize(width: self.size.width, height: self.size.height))
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
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let positionInScene = touch.location(in: self)
        
        selectNodeForTouch(touchLocation: positionInScene)
    }
    
    func selectNodeForTouch(touchLocation: CGPoint) {
        
        selectedNode = Letter()
        
        let touchedNode = self.atPoint(touchLocation)
        if touchedNode is Letter {
            
            if !(selectedNode?.isEqual(touchedNode))! && selectedNode != nil{
                selectedNode?.removeAllActions()
                selectedNode?.run(SKAction.rotate(toAngle: 0.0, duration: 0.1))
                
                selectedNode = touchedNode as? Letter
            }
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
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        letterIsInsideBox()
        
    }
    
    func letterIsInsideBox() {
        
        for box in boxArray {
            
            let xMin = box.position.x - box.size.width/2
            let xMax = box.position.x + box.size.width/2
            let yMin = box.position.y - box.anchorPoint.y*box.size.height
            let yMax = box.position.y + (1-box.anchorPoint.y)*box.size.height
            
            if (selectedNode?.position.x)! > xMin && (selectedNode?.position.x)! < xMax && (selectedNode?.position.y)! > yMin && (selectedNode?.position.y)! < yMax {
                
                if selectedNode?.text?.characters.first == box.boxLetter {
                    
                    print("correct letter")
                    
                }
                
            }
            
        }
        
    }
    
}
