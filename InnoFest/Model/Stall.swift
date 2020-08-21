//
//  Stalls.swift
//  InnoFest
//
//  Created by Ryan The on 15/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import Foundation

enum StallModelType {
	case select, set
}

struct FoodItem {
	var name: String
	var price: Double
}

class Stall {
	var name: String
	var description: String
	var model: StallModelType
	var isFavourite: Bool
	var foodItems: [FoodItem]
	
	init(name: String, description: String, model: StallModelType, isFavourite: Bool, foodItems: [FoodItem]) {
		self.name = name
		self.description = description
		self.model = model
		self.isFavourite = isFavourite
		self.foodItems = foodItems
	}
	
	static func getStalls() {
		
	}
}
