//
//  MenuViewController.swift
//  Decifrando
//
//  Created by Ana Luiza Ferrer on 05/11/16.
//
//

import Foundation
import UIKit

class MenuViewController: UIViewController {
    
    var menu: MenuView!

    override func viewDidLoad() {
        self.menu = MenuView(frame: CGRect(x: 0,y: 0,width: view.frame.width,height: view.frame.height))
        self.view = menu
        
    }
    
    
}
