//
//  Stalls.swift
//  Barg-InnoFest
//
//  Created by Ryan The on 15/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum StallModelType {
	case select, set
}

struct FoodItemDetails {
    
}

class Stall {
	var name: String
	var desc: String
	var model: StallModelType
	var foodItems: [FoodItem]
	
	init(name: String, desc: String, model: StallModelType, foodItems: [FoodItem]) {
		self.name = name
		self.desc = desc
		self.model = model
		self.foodItems = foodItems
	}
	
	static func getStalls() {
        
	}
    
    static func fromQuerySnapshot(_ snapshot: QuerySnapshot) -> [Stall] {
        return snapshot.documents.map { (document) -> Stall in
            let dictionary = document.data()
            return Stall(name: dictionary["name"] as! String, desc: dictionary["desc"] as! String, model: dictionary["model"] as! StallModelType, foodItems: dictionary["foodItems"] as! [FoodItem])
        }
    }
}
