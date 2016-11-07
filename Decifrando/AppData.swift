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
    var levelsList = [NSManagedObject]()
    
    private init(){}
    
    class func createSingleton() -> AppData {
        return sharedInstance
    }
    
}
