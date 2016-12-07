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
    
    var lastPos : CGPoint!
    
    //var mySkNode: SKNode!
    //var panGestureRecognizer: UIPanGestureRecognizer!
    //var pinchGestureRecognizer: UIPinchGestureRecognizer!

    
    override func didMove(to view: SKView) {
        
        background = SKSpriteNode(imageNamed: "animalsWorld")
        self.background.name = "animalsWorld"
        self.addChild(background)
        
        createLevelLabels()
        
        cam = SKCameraNode()
        cam.setScale(CGFloat(1.5))
        
        self.camera = cam
        self.addChild(cam)
        
        let s = getAspectFitSize(toX: 50, toY: 50)
        let backButton = SKSpriteNode(imageNamed: "backButton")

        background.position = CGPoint(x: size.width/2,y: s.height/2)
        backButton.size = s
        backButton.zPosition = 1
//        backButton.position = CGPoint(x: size.width/8, y: 9*size.height/10)
        backButton.position = CGPoint(x: -130, y: 830)
        backButton.name = "Back"
        
        self.addChild(backButton)
        
        
        //position the camera on the gamescene.
        cam.position = CGPoint(x: size.width/2, y: size.height/2)
        
//        self.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan))
//        self.view?.addGestureRecognizer(panGestureRecognizer)
        
//        self.pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.handleZoom))
//        self.view?.addGestureRecognizer(pinchGestureRecognizer)
        
    }
    
//    func handlePan(from recognizer: UIPanGestureRecognizer) {
//        if recognizer.state == .began {
//            recognizer.setTranslation(CGPoint.zero, in: recognizer.view)
//        }
//        else if recognizer.state == .changed {
//            var translation = recognizer.translation(in: recognizer.view)
//            translation = CGPoint(x: CGFloat(-translation.x), y: CGFloat(translation.y))
//            self.mySkNode.position = CGPoint(x: mySkNode.position.x - translation.x, y: mySkNode.position.y - translation.y)
//            recognizer.setTranslation(CGPoint.zero, in: recognizer.view)
//        }
//        else if recognizer.state == .ended {
//            // No code needed for panning.
//        }
//        
//    }
    
//    func handleZoom(from recognizer: UIPinchGestureRecognizer) {
//        
//        var anchorPoint = recognizer.location(in: recognizer.view)
//        anchorPoint = self.convertPoint(fromView: anchorPoint)
//        
//        if recognizer.state == .began {
//           
//            // No code needed for zooming...
//        
//        } else if recognizer.state == .changed {
//           
//            let anchorPointInMySkNode = mySkNode.convert(anchorPoint, from: self)
//            mySkNode.setScale((mySkNode.xScale * recognizer.scale))
//            let mySkNodeAnchorPointInScene = self.convert(anchorPointInMySkNode, from: mySkNode)
//            let translationOfAnchorInScene = CGPoint(x: anchorPoint.x - mySkNodeAnchorPointInScene.x, y: anchorPoint.y - mySkNodeAnchorPointInScene.y)
//            self.mySkNode.position = CGPoint(x: mySkNode.position.x + translationOfAnchorInScene.x, y: mySkNode.position.y + translationOfAnchorInScene.y)
//            recognizer.scale = 1.0
//        
//        } else if recognizer.state == .ended {
//           
//            // No code needed here for zooming...
//        }
//        
//    }

    
    /*
     
     // Method that is called by my UIPinchGestureRecognizer.
     
     func handleZoom(from recognizer: UIPinchGestureRecognizer) {
     var anchorPoint = recognizer.location(in: recognizer.view)
     anchorPoint = self.convertPoint(fromView: anchorPoint)
     if recognizer.state == .began {
     // No code needed for zooming...
     }
     else if recognizer.state == .changed {
     var anchorPointInMySkNode = mySkNode.convertPoint(anchorPoint, from: self)
     mySkNode.setScale((mySkNode.xScale * recognizer.scale))
     var mySkNodeAnchorPointInScene = self.convertPoint(anchorPointInMySkNode, from: mySkNode)
     var translationOfAnchorInScene = CGPointSubtract(anchorPoint, mySkNodeAnchorPointInScene)
     self.mySkNode.position = CGPointAdd(mySkNode.position, translationOfAnchorInScene)
     recognizer.scale = 1.0
     }
     else if recognizer.state == .ended {
     // No code needed here for zooming...
     }
     
     }
     */
    
    
//    override func update(_ currentTime: TimeInterval) {
//        let zoomInAction = SKAction.scale(to: 0.5, duration: 1)
//        cam.run(zoomInAction)
//    }
//    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        lastPos = touches.first!.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let p = touches.first!.location(in: self)
        let dist = CGPoint(x: p.x-lastPos.x,y: p.y-lastPos.y)
        let bp = background.position
        background.position.x = max(min(background.size.width/3,bp.x+dist.x),size.width-background.size.width/3)
        background.position.y = max(min(background.size.height/2.5,bp.y+dist.y),size.height-background.size.height/2.5)
        lastPos = p
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        let node = self.atPoint(touchLocation)
        
        if node.name == "Back" {
            
            run(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: false))
            self.returnToMenuScene()
            
        }
        
        else {
            
            let index = node.name?.index((node.name?.startIndex)!, offsetBy:5)
            let name = node.name?.substring(to:index!)
            
            if name == "Level" {
                
                run(SKAction.playSoundFileNamed("click.mp3", waitForCompletion: false))
                
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
        
       let labelPositions: [CGPoint] = [CGPoint(x: -808, y: -898), CGPoint(x: 259, y: -108), CGPoint(x: 789, y: 420), CGPoint(x: 325, y: 853), CGPoint(x: -689, y: 515)]
        let pathPositions: [CGPoint] = [CGPoint(x: -1008, y: -1300), CGPoint(x: -997, y: -1310), CGPoint(x: -960, y: -1320), CGPoint(x: -1000, y: -1320)]
        
        for n in 1...AppData.sharedInstance.levelsList.count {
            
            var levelLabel: SKSpriteNode
            
            print(n)
            
            if AppData.sharedInstance.levelsList[n-1].completed == true {
                
                levelLabel = SKSpriteNode(imageNamed: "lvl\(n)Red")
                
                if n == AppData.sharedInstance.levelsList.count {
                    
                    var i = 2
                    while i <= n {
                        
                        let path = SKSpriteNode(imageNamed: "\(i-1)to\(i)")
                        path.anchorPoint = CGPoint.zero
                        path.zPosition = 1
                        path.position = pathPositions[i-2]
                        background.addChild(path)
                        i += 1
                    }
                }
                
            } else if nextLevel == -1 {
                    
                levelLabel = SKSpriteNode(imageNamed: String(n))
                    
                nextLevel = n
                
                if n > 1 && n <= AppData.sharedInstance.levelsList.count {
                    
                    var i = 2
                    while i <= n {
                        
                        let path = SKSpriteNode(imageNamed: "\(i-1)to\(i)")
                        path.anchorPoint = CGPoint.zero
                        path.zPosition = 1
                        path.position = pathPositions[i-2]
                        background.addChild(path)
                        i += 1
                    }
                }

                    
            } else {
                 
                levelLabel = SKSpriteNode(imageNamed: "lvl\(n)Black")
            }
            
            levelLabel.position = labelPositions[n-1]
            levelLabel.zPosition = 2
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
