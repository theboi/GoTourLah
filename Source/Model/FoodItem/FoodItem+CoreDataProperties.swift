//
//  FoodItem+CoreDataProperties.swift
//  
//
//  Created by Ryan The on 11/9/20.
//
//

import Foundation
import CoreData


extension FoodItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodItem> {
        return NSFetchRequest<FoodItem>(entityName: "FoodItem")
    }

    @NSManaged public var desc: String
    @NSManaged public var name: String
    @NSManaged public var price: Double

}
