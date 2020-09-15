//
//  Constants.swift
//  Barg-InnoFest
//
//  Created by Ryan The on 16/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

struct StallOwner {
    var email: String
    var storeName: String
}

struct DbCollectionNames {
    let foodItems = "stall-foodItems"
    let orders = "stall-orders"
    let users = "users"
}

class K {
	static let marginCg: CGFloat = 20
	static let cornerRadiusCg: CGFloat = 15
	static let borderWidthCg: CGFloat = 1
    static let buttonHeight: CGFloat = 50
	static let tintColor = UIColor.link
	static let placeholderImage = UIImage(named: "food")
    
    static let dbCollectionNames = DbCollectionNames()
    
    static let stallOwner = StallOwner(email: "ryan_theodore_the@s2019.ssts.edu.sg", storeName: "Chinese Rice")
}
