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

class Stall {
	var name: String
	var description: String
//	var model: StallModelType
//	var isFavourite: Bool
//	var foodItems = [String: Double]()
	//, model: StallModelType, isFavourite: Bool, foodItems: [String: Double]
	init(name: String, description: String) {
		self.name = name
		self.description = description
//		self.model = model
//		self.isFavourite = isFavourite
	}
	
	static func getStalls() {
		
	}
}
