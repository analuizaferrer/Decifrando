//
//  ViewController.swift
//  Decifrando
//
//  Created by Ana Luiza Ferrer on 03/11/16.
//
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var menu: MenuView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menu = MenuView(frame: CGRect(x: 0,y: 0,width: view.frame.width,height: view.frame.height))
        self.view = menu
        
//        if let view = self.view as! SKView? {
//            // Load the SKScene from 'GameScene.sks'
//            
//            let scene = LevelScene(size: view.bounds.size)
//            
//            scene.scaleMode = .aspectFill
//            view.presentScene(scene)
//            view.ignoresSiblingOrder = true
//            
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
    
    }
    
//    override func viewWillLayoutSubviews() {
//        // Configure the view.
//        let skView = self.view as! SKView
//        skView.showsFPS = true
//        skView.showsNodeCount = true
//        
//        /* Sprite Kit applies additional optimizations to improve rendering performance */
//        skView.ignoresSiblingOrder = true
//       
//        //let scene = LevelScene(size: skView.frame.size)
//        
//        /* Set the scale mode to scale to fit the window */
//        //scene.scaleMode = .aspectFill
//        
//        //skView.presentScene(scene)
//    }
    
}
