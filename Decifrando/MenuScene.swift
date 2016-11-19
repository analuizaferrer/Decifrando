//
//  MenuScene.swift
//  Decifrando
//
//  Created by Helena Leitão on 07/11/16.
//
//

import Foundation
import SpriteKit

class MenuScene: SKScene {

    var background: SKSpriteNode!
    var animals: SKSpriteNode!
    var colors: SKSpriteNode!
    var fruits: SKSpriteNode!
    var vehicles: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        background = SKSpriteNode(imageNamed:"backgroundLetras")
   background.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
     
//        background = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: self.size.width, height: self.size.height))
//        self.background.name = "backgroundLetras"
        self.background.anchorPoint = CGPoint.zero
        self.background.zPosition = 0
        self.addChild(background)
        
        self.createMenuLabels()
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        let node = self.atPoint(touchLocation)
        
        if node.name == "animals" || node.name == "colors" || node.name == "fruits" || node.name == "vehicles" {
        
            self.showCategoryMap(category: node.name!)
        }
        
    }
    
    func showCategoryMap(category: String) {
        
        DAO().fetchCategory(category: category)
        let reveal = SKTransition.fade(withDuration: 1.0)
        let scene = CategoryScene(size: size)
        self.view?.presentScene(scene, transition:reveal)

    }

    func createMenuLabels() {
        
        animals = SKSpriteNode(imageNamed: "animals")
        self.animals.size = CGSize(width: 380, height: 242)
        self.animals.name = "animals"
        self.animals.anchorPoint = CGPoint.zero
        self.animals.position = CGPoint(x: size.width/2-400, y: size.height/2+20)
        self.animals.zPosition = 1
        background.addChild(animals)
        
        
//        background = SKSpriteNode(imageNamed:"background")
//        background.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        colors = SKSpriteNode(imageNamed: "boxLocked")
        self.colors.size = CGSize(width: 380, height: 242)
        self.colors.name = "colors"
        self.colors.anchorPoint = CGPoint.zero
        self.colors.position = CGPoint(x: size.width/2+50, y: size.height/2+20)
        self.colors.zPosition = 1

        background.addChild(colors)
        
        fruits = SKSpriteNode(imageNamed: "boxLocked")
        self.fruits.size = CGSize(width: 380, height: 242)
        self.fruits.name = "fruits"
        self.fruits.anchorPoint = CGPoint.zero
        self.fruits.position = CGPoint(x: size.width/2-400, y: 50+20)
        self.fruits.zPosition = 1

        background.addChild(fruits)
        
        vehicles = SKSpriteNode(imageNamed: "boxLocked")
        self.vehicles.size = CGSize(width: 380, height: 242)
        self.vehicles.name = "vehicles"
        self.vehicles.anchorPoint = CGPoint.zero
        self.vehicles.position = CGPoint(x: size.width/2+50, y: 50+20)
        self.vehicles.zPosition = 1

        background.addChild(vehicles)
        
    }
    
}
