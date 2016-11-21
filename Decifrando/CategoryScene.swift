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
        
//        background = SKSpriteNode(color: UIColor.green, size: CGSize(width: self.size.width, height: self.size.height))
        background = SKSpriteNode(imageNamed: "animalsWorld")
        self.background.name = "animalsWorld"
        self.background.anchorPoint = CGPoint.zero
        self.addChild(background)
        
        createLevelLabels()
        
        let s = getAspectFitSize(toX: 130, toY: 130)
        let backButton = SKSpriteNode(imageNamed: "backButton")
//        backLabel.text = "Voltar"
//        backLabel.fontSize = 40
//        backLabel.fontColor = SKColor.black
        backButton.size = s
//        backButton.position = CGPoint(x: size.width/8, y: 9*size.height/10)
        backButton.position = CGPoint(x: 400, y: 400)
        addChild(backButton)
        backButton.name = "Back"
        

        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        let node = self.atPoint(touchLocation)
        
        if node.name == "Back" {
            
            self.returnToMenuScene()
            
        }
        
        else {
            
            let index = node.name?.index((node.name?.startIndex)!, offsetBy:5)
            let name = node.name?.substring(to:index!)
            
            if name == "Level" {
                
                let nodeNameArray = node.name?.components(separatedBy: " ")
                let levelNumberText = nodeNameArray?[1]
                
                AppData.sharedInstance.selectedLevelIndex = Int(levelNumberText!)!-1
                
                if AppData.sharedInstance.selectedLevelIndex == 0 {
                    
                    self.startLevel()
                    
                }
                    
                else if AppData.sharedInstance.levelsList[AppData.sharedInstance.selectedLevelIndex-1].completed == true {
                    
                    self.startLevel()
                    
                }
                
            }
            
        }
        
    }
    
    func startLevel() {
        let reveal = SKTransition.fade(withDuration: 1.0)
        let scene = LevelScene(size: size)
        self.view?.presentScene(scene, transition:reveal)
    }
    
    func createLevelLabels() {
        
        let labelPositions: [CGPoint] = [CGPoint(x: size.width/2, y: size.height/6), CGPoint(x: size.width/2, y: 2*size.height/6), CGPoint(x: size.width/2, y: 3*size.height/6), CGPoint(x: size.width/2, y: 4*size.height/6), CGPoint(x: size.width/2, y: 5*size.height/6)]
        
        var levelLabels = [SKLabelNode]()
        
        for n in 1...AppData.sharedInstance.levelsList.count {
            
            let levelLabel = SKLabelNode(fontNamed: "Riffic")
            levelLabel.text = "\(n)"
            levelLabel.fontSize = 40
            
            if AppData.sharedInstance.levelsList[n-1].completed == true
            {
                levelLabel.fontColor = SKColor.red
            }
            
            else {
                
                levelLabel.fontColor = SKColor.black
                
            }
            
            levelLabel.position = labelPositions[n-1]
            addChild(levelLabel)
            levelLabel.name = "Level \(n)"
            levelLabels.append(levelLabel)
            
        }
        
    }
    
    func returnToMenuScene() {
        
        let reveal = SKTransition.fade(withDuration: 1.0)
        let scene = MenuScene(size: size)
        self.view?.presentScene(scene, transition:reveal)
        
        DAO().updateLevelCompleted(category: AppData.sharedInstance.levelsList[0].category)
        
    }
    
}
