//
//  DAO.swift
//  Decifrando
//
//  Created by Ana Luiza Ferrer on 06/11/16.
//
//

import Foundation
import CoreData
import UIKit

class DAO {
    
    func save (word: String, image: String, category: String, completed: Bool) {
        
        let appDelegate: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let managedContext: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Level", in: managedContext)
        
        let level = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        level.setValue(word, forKey: "word")
        level.setValue(image, forKey: "image")
        level.setValue(category, forKey: "category")
        level.setValue(completed, forKey: "completed")
        
        do {
            
            try managedContext.save()
            AppData.sharedInstance.levelsList.append(level)
            
        }
        
        catch {
            
            print("error")
    
        }
        
    }
    
    func fetch () {
        
        let appDelegate: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let managedContext: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Level")
        
        do {
           
            let results = try managedContext.fetch(fetchRequest)
            AppData.sharedInstance.levelsList = results as! [NSManagedObject]
            
        }
        
        catch {
            
            print("error")
            
        }
        
    }
    
    
}
