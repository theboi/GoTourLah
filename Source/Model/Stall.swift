//
//  Stalls.swift
//  Barg-InnoFest
//
//  Created by Ryan The on 15/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum StallModelType: String {
	case select = "select", set = "set"
}

struct FoodItemDetails {
    var name: String
    var desc: String
    var price: Double
}

class Stall {
	var name: String
	var desc: String
	var model: StallModelType
	var foodItems: [FoodItemDetails]
	
	init(name: String, desc: String, model: StallModelType, foodItems: [FoodItemDetails]) {
		self.name = name
		self.desc = desc
		self.model = model
		self.foodItems = foodItems
	}
	
	static func getStalls() {
        
	}
    
    static func fromQuerySnapshot(_ snapshot: QuerySnapshot) -> [Stall] {
        return snapshot.documents.map { (document) -> Stall in
            let documentData = document.data()
//            print("%@", documentData["foodItems"] as! [FoodItemDetails])
            
            let foodItems = (documentData["foodItems"] as! [[String: Any]]).map { (foodItem) -> FoodItemDetails in
                return FoodItemDetails(name: foodItem["name"] as! String, desc: foodItem["desc"] as! String, price: foodItem["price"] as! Double)
            }
            
//            return Stall(name: "", desc: "", model: .select, foodItems: [])
            return Stall(name: documentData["name"] as! String, desc: documentData["desc"] as! String, model: StallModelType(rawValue: documentData["model"] as! String) ?? .select, foodItems: foodItems)
        }
    }
}
