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
    
//	var cart: [String] {
//		return [""]
//	}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Cart")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("ERROR: %@ \(error)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = (UIApplication.shared.delegate as! AppDelegate).cart.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("ERROR: %@ \(error)")
            }
        }
    }
    
    func getContext() -> [FoodItem] {
        let context = (UIApplication.shared.delegate as! AppDelegate).cart.persistentContainer.viewContext
        var cart: [FoodItem]
        do {
            cart = try context.fetch(FoodItem.fetchRequest())
        } catch let error as NSError {
            fatalError("ERROR: %@ \(error)")
        }
        return cart
    }
	
    func addToCart(foodItem: FoodItem, fromStall: Stall) {
        NSManagedObject(entity: foodItem.entity, insertInto: persistentContainer.viewContext)
	}
    
    func getFoodItems() {
        
    }
}
