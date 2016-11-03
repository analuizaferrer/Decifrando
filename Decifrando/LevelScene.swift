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

    let correctWord = "batata"
    var boxArray: [Box]!
    var lettersArray: [Letter]!
    
    var background: SKSpriteNode!
    
    var selectedNode = Letter()
    
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
            background.addChild(letter)
            letter.zPosition = 20
            j = j + 1
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let positionInScene = touch.location(in: self)
        
        selectNodeForTouch(touchLocation: positionInScene)
    }
    
    func degToRad(degree: Double) -> CGFloat {
        return CGFloat(Double(degree) / 180.0 * M_PI)
    }
    
    func selectNodeForTouch(touchLocation: CGPoint) {
        // 1
        let touchedNode = self.atPoint(touchLocation)
        if touchedNode is Letter {
            // 2
            if !selectedNode.isEqual(touchedNode) {
                selectedNode.removeAllActions()
                selectedNode.run(SKAction.rotate(toAngle: 0.0, duration: 0.1))
                
                selectedNode = touchedNode as! Letter
                
                // 3
                if touchedNode.name! == Letter.kLetterNodeName {
                    let sequence = SKAction.sequence([SKAction.rotate(byAngle: degToRad(degree: -4.0), duration: 0.1),
                                                      SKAction.rotate(byAngle: 0.0, duration: 0.1),
                                                      SKAction.rotate(byAngle: degToRad(degree: 4.0), duration: 0.1)])
                    selectedNode.run(SKAction.repeatForever(sequence))
                }
            }
        }
    }
    
    func boundLayerPos(aNewPosition: CGPoint) -> CGPoint {
        let winSize = self.size
        var retval = aNewPosition
        retval.x = CGFloat(min(retval.x, 0))
        retval.x = CGFloat(max(retval.x, -(background.size.width) + winSize.width))
        retval.y = self.position.y
        
        return retval
    }
    
    func panForTranslation(translation: CGPoint) {
        let position = selectedNode.position
        
        if selectedNode.name != nil && selectedNode.name! == Letter.kLetterNodeName {
            print("entrei")
            selectedNode.position = CGPoint(x: position.x + translation.x, y: position.y + translation.y)
        } else {
            print("entrei2w2")
            if (selectedNode.name != nil)
            {
                print(selectedNode.name)
            }
            let aNewPosition = CGPoint(x: position.x + translation.x, y: position.y + translation.y)
            background.position = self.boundLayerPos(aNewPosition: aNewPosition)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if touches.first != nil {
        let touch = touches.first!
        let positionInScene = touch.location(in: self)
        let previousPosition = touch.previousLocation(in: self)
        let translation = CGPoint(x: positionInScene.x - previousPosition.x, y: positionInScene.y - previousPosition.y)
        
            if atPoint(positionInScene).name != nil && atPoint(positionInScene).name == Letter.kLetterNodeName {
            
                panForTranslation(translation: translation)}
        }
    }
    
}

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (unshuffledCount, firstUnshuffled) in zip(stride(from: c, to: 1, by: -1), indices) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}
