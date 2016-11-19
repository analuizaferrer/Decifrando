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
            
        } catch {
            
            print("error")
    
        }
    }
    
    func fetch () {
        
        var managedObjectArray = [NSManagedObject]()
        
        let appDelegate: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let managedContext: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "WordLevel")
        
        do {
           
            let results = try managedContext.fetch(fetchRequest)
            managedObjectArray = results as! [NSManagedObject]
            convertManagedObject(managedObjectArray: managedObjectArray)
            
        } catch {
            
            print("error")
            
        }
    }
    
    func fetchCategory (category: String) {
        
        let appDelegate: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let managedContext: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "WordLevel")
        fetchRequest.predicate = NSPredicate(format: "category == %@", category)
        
        do {
            
            let results = try managedContext.fetch(fetchRequest)
            
            if results.count != 0 {
                
                let managedObjectArray = results as! [NSManagedObject]
                convertManagedObject(managedObjectArray: managedObjectArray)
                
            }
            
        } catch {
            
            print("error")
            
        }
    }
    
    func convertManagedObject(managedObjectArray: [NSManagedObject]) {
        
        AppData.sharedInstance.levelsList = []
        
        for object in managedObjectArray {
            
            let levelNumber = object.value(forKey: "levelNumber") as! Int
            let word = object.value(forKey: "word") as! String
            let image = object.value(forKey: "image") as! String
            let category = object.value(forKey: "category") as! String
            let completed = object.value(forKey: "completed") as! Bool
            
            let level = Level(levelNumber: levelNumber, word: word, image: image, category: category, completed: completed)
            
            AppData.sharedInstance.levelsList.append(level)
            
        }
        
    }
    
    func updateLevelCompleted(category: String) {
        
        let appDelegate: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let managedContext: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "WordLevel")
        fetchRequest.predicate = NSPredicate(format: "category == %@", category)
        
        do {
            
            let results = try managedContext.fetch(fetchRequest)
            
            if results.count != 0 {
                
                let managedObjectArray = results as! [NSManagedObject]
                
                for i in 0...AppData.sharedInstance.levelsList.count-1 {
                    
                    managedObjectArray[i].setValue(AppData.sharedInstance.levelsList[i].completed, forKey: "completed")
                }
                
                try! managedContext.save()
                
            }
            
        } catch {
            
            print("error")
            
        }
    }
    
    func populateDatabase () {
        
        let animalLevelsList: [Level] = [Level(levelNumber: 1, word: "gato", image: "image", category: "animals", completed: false), Level(levelNumber: 2, word: "cavalo", image: "image", category: "animals", completed: false), Level(levelNumber: 3, word: "coruja", image: "image", category: "animals", completed: false), Level(levelNumber: 4, word: "peixe", image: "image", category: "animals", completed: false), Level(levelNumber: 5, word: "papagaio", image: "image", category: "animals", completed: false)]
        
        let colorLevelsList: [Level] = [Level(levelNumber: 1, word: "vermelho", image: "image", category: "colors", completed: false), Level(levelNumber: 2, word: "amarelo", image: "image", category: "colors", completed: false), Level(levelNumber: 3, word: "laranja", image: "image", category: "colors", completed: false), Level(levelNumber: 4, word: "verde", image: "image", category: "colors", completed: false), Level(levelNumber: 5, word: "azul", image: "image", category: "colors", completed: false)]
        
        let fruitLevelsList: [Level] = [Level(levelNumber: 1, word: "uva", image: "image", category: "fruits", completed: false), Level(levelNumber: 2, word: "banana", image: "image", category: "fruits", completed: false), Level(levelNumber: 3, word: "morango", image: "image", category: "fruits", completed: false), Level(levelNumber: 4, word: "abacaxi", image: "image", category: "fruits", completed: false), Level(levelNumber: 5, word: "melancia", image: "image", category: "fruits", completed: false)]
        
        let vehicleLevelsList: [Level] = [Level(levelNumber: 1, word: "ônibus", image: "image", category: "vehicles", completed: false), Level(levelNumber: 2, word: "carro", image: "image", category: "vehicles", completed: false), Level(levelNumber: 3, word: "caminhão", image: "image", category: "vehicles", completed: false), Level(levelNumber: 4, word: "bicicleta", image: "image", category: "vehicles", completed: false), Level(levelNumber: 5, word: "skate", image: "image", category: "vehicles", completed: false)]

        
        for level in animalLevelsList {
            
            DAO().save(levelNumber: level.levelNumber, word: level.word, image: level.image, category: level.category, completed: level.completed)
            
        }
        
        for level in colorLevelsList {
            
            DAO().save(levelNumber: level.levelNumber, word: level.word, image: level.image, category: level.category, completed: level.completed)
            
        }
        
        for level in fruitLevelsList {
            
            DAO().save(levelNumber: level.levelNumber, word: level.word, image: level.image, category: level.category, completed: level.completed)
            
        }
        
        for level in vehicleLevelsList {
            
            DAO().save(levelNumber: level.levelNumber, word: level.word, image: level.image, category: level.category, completed: level.completed)
            
        }
    }
}
