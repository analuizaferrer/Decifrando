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
        
        background = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: self.size.width, height: self.size.height))
        self.background.name = "background"
        self.background.anchorPoint = CGPoint.zero
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
            self.chooseCategory()
        }
        
    }
    
    func chooseCategory() {
        let reveal = SKTransition.fade(withDuration: 1.0)
        let scene = CategoryScene(size: size)
        self.view?.presentScene(scene, transition:reveal)
    }

    func createMenuLabels() {
        
        animals = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 300, height: 300))
        self.animals.name = "animals"
        self.animals.anchorPoint = CGPoint.zero
        self.animals.position = CGPoint(x: size.width/2-350, y: size.height/2)
        background.addChild(animals)
        
        colors = SKSpriteNode(color: UIColor.cyan, size: CGSize(width: 300, height: 300))
        self.colors.name = "colors"
        self.colors.anchorPoint = CGPoint.zero
        self.colors.position = CGPoint(x: size.width/2+50, y: size.height/2)
        background.addChild(colors)
        
        fruits = SKSpriteNode(color: UIColor.purple, size: CGSize(width: 300, height: 300))
        self.fruits.name = "fruits"
        self.fruits.anchorPoint = CGPoint.zero
        self.fruits.position = CGPoint(x: size.width/2-350, y: 50)
        background.addChild(fruits)
        
        vehicles = SKSpriteNode(color: UIColor.orange, size: CGSize(width: 300, height: 300))
        self.vehicles.name = "vehicles"
        self.vehicles.anchorPoint = CGPoint.zero
        self.vehicles.position = CGPoint(x: size.width/2+50, y: 50)
        background.addChild(vehicles)
        
    }
    
}
