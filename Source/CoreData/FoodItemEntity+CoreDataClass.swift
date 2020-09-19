//
//  FoodItemEntity+CoreDataClass.swift
//  
//
//  Created by Ryan The on 12/9/20.
//
//

import Foundation
import CoreData

@objc(FoodItemEntity)
public class FoodItemEntity: NSManagedObject, FoodItem {
    var toDictionary: [String: Any] {
        return [
            "name": self.name,
            "desc": self.desc,
            "model": self.price,
        ]
    }
}
