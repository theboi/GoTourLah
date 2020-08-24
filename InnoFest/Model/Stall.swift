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
	var desc: String
	var price: Double
	var isFavourite: Bool
	var stallName: String
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
}
