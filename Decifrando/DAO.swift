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
    
    func save (levelNumber: Int, word: String, image: String, category: String, completed: Bool) {
        
        let appDelegate: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let managedContext: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "WordLevel", in: managedContext)
        
        let level = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        level.setValue(levelNumber, forKey: "levelNumber")
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
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "WordLevel")
        
        do {
           
            let results = try managedContext.fetch(fetchRequest)
            AppData.sharedInstance.levelsList = results as! [NSManagedObject]
            
        }
        
        catch {
            
            print("error")
            
        }
        
    }
    
    func populateDatabase () {
        
        let levelsList: [Level] = [Level(levelNumber: 1, word: "gato", image: "image", category: "animal", completed: false), Level(levelNumber: 2, word: "cachorro", image: "image", category: "animal", completed: false), Level(levelNumber: 3, word: "golfinho", image: "image", category: "animal", completed: false), Level(levelNumber: 4, word: "cavalo", image: "image", category: "animal", completed: false), Level(levelNumber: 5, word: "elefante", image: "image", category: "animal", completed: false)]
        
        for level in levelsList {
            
            DAO().save(levelNumber: level.levelNumber, word: level.word, image: level.image, category: level.category, completed: level.completed)
            
        }
        
    }

}
