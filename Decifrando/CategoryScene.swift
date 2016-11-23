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
    var cam: SKCameraNode!
    
    var levelLabels = [SKSpriteNode]()
    var nextLevel = -1
    
    override func didMove(to view: SKView) {
        
//        background = SKSpriteNode(color: UIColor.green, size: CGSize(width: self.size.width, height: self.size.height))
        background = SKSpriteNode(imageNamed: "animalsWorld")
        self.background.name = "animalsWorld"
        self.addChild(background)
        
        createLevelLabels()
        
        cam = SKCameraNode()
        cam.setScale(CGFloat(1))
        
        self.camera = cam
        self.addChild(cam)
        
        let s = getAspectFitSize(toX: 50, toY: 50)
        let backButton = SKSpriteNode(imageNamed: "backButton")
//        backLabel.text = "Voltar"
//        backLabel.fontSize = 40
        //        backLabel.fontColor = SKColor.black
        background.position = CGPoint(x: size.width/2,y: s.height/2)
        backButton.size = s
        backButton.zPosition = 1
//        backButton.position = CGPoint(x: size.width/8, y: 9*size.height/10)
        backButton.position = CGPoint(x: 120, y: 900)
        backButton.name = "Back"
        cam.addChild(backButton)
        
        
        
        //position the camera on the gamescene.
        cam.position = CGPoint(x: size.width/2 - level, y: size.height/2)
        
    }
    
    var lastPos : CGPoint!
    
//    override func update(_ currentTime: TimeInterval) {
//        let zoomInAction = SKAction.scale(to: 0.5, duration: 1)
//        cam.run(zoomInAction)
//    }
//    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastPos = touches.first!.location(in: self)
        
        //print("POSITION: \(touches.first!.location(in: background))")
        

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let p = touches.first!.location(in: self)
        let dist = CGPoint(x: p.x-lastPos.x,y: p.y-lastPos.y)
        let bp = background.position
        background.position.x = max(min(background.size.width/2,bp.x+dist.x),size.width-background.size.width/2)
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
        
//        let labelPositions: [CGPoint] = [CGPoint(x: size.width/10, y: size.height/6), CGPoint(x: size.width/20, y: 2*size.height/40), CGPoint(x: size.width/25, y: 3*size.height/65), CGPoint(x: size.width/100, y: 4*size.height/36), CGPoint(x: size.width/2, y: 5*size.height/6)]
        
       let labelPositions: [CGPoint] = [CGPoint(x: -808, y: -898), CGPoint(x: 259, y: -108), CGPoint(x: 789, y: 420), CGPoint(x: 325, y: 853), CGPoint(x: -689, y: 515)]
        
        for n in 1...AppData.sharedInstance.levelsList.count {
            
            var levelLabel: SKSpriteNode
            
            if AppData.sharedInstance.levelsList[n-1].completed == true
            {
                
                levelLabel = SKSpriteNode(imageNamed: "lvl\(n)Red")
                
            }
            
            else {
                
                if nextLevel == -1 {
                    
                    levelLabel = SKSpriteNode(imageNamed: String(n))
                    
                    nextLevel = n
                    
                }
                
                else {
                 
                    levelLabel = SKSpriteNode(imageNamed: "lvl\(n)Black")
                    
                }
                
            }
            
            levelLabel.position = labelPositions[n-1]
            levelLabel.zPosition = 1
            levelLabel.size = CGSize(width: 200, height: 200)
            levelLabel.name = "Level \(n)"
            levelLabels.append(levelLabel)
            background.addChild(levelLabel)
        }
        
        if nextLevel == -1 {
            
            nextLevel = levelLabels.count
            
        }
        
    }
    
    func returnToMenuScene() {
        
        let reveal = SKTransition.fade(withDuration: 1.0)
        let scene = MenuScene(size: size)
        self.view?.presentScene(scene, transition:reveal)
        
    }
    
}
