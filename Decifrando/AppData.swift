//
//  AppData.swift
//  Decifrando
//
//  Created by Ana Luiza Ferrer on 06/11/16.
//
//

import Foundation
import CoreData

class AppData {
    
    static let sharedInstance = AppData()
    var levelsList = [Level]()
    var selectedLevel: Int = 0
    
    private init(){}
    
}
