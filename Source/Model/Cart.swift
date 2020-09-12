//
//  Cart.swift
//  Barg-InnoFest
//
//  Created by Ryan The on 23/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit
import CoreData

class Cart {
    
    var foodItems: [FoodItemDetails] = []
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Barg-InnoFest")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("ERROR: %@ \(error)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("ERROR: %@ \(error)")
            }
        }
    }
    
    func getContext() -> [FoodItem] {
        let context = persistentContainer.viewContext
        
        var cart: [FoodItem]
        do {
            cart = try context.fetch(FoodItem.fetchRequest())
        } catch let error as NSError {
            fatalError("ERROR: %@ \(error)")
        }
        return cart
    }
    
    func addToCart(_ foodItemDetails: FoodItemDetails) {
        let managedContext = persistentContainer.viewContext
        print("managedContext", managedContext)
        let entity = NSEntityDescription.entity(forEntityName: "FoodItem", in: managedContext)!
        let foodItem = FoodItem(entity: entity, insertInto: managedContext)
        foodItem.name = foodItemDetails.name
        foodItem.desc = foodItemDetails.desc
        foodItem.price = foodItemDetails.price
        
        do {
            try managedContext.save()
            self.foodItems.append(foodItemDetails)
        } catch let error as NSError {
            fatalError("ERROR: %@ \(error)")
        }
    }
    
    func getFoodItems() {
        
    }
}
