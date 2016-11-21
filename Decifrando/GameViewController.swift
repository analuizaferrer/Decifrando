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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SizeSettings.screenSize = view.frame.size
        
        for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            
//            DAO().fetch()
            
            let scene = HomeScene(size: view.bounds.size)
            //let scene = CategoryScene(size: view.bounds.size)
            
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        
    
    }
    
    override func viewWillLayoutSubviews() {
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
       
        //let scene = LevelScene(size: skView.frame.size)
        
        /* Set the scale mode to scale to fit the window */
        //scene.scaleMode = .aspectFill
        
        //skView.presentScene(scene)
    }
    
}
