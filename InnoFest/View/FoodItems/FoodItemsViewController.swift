//
//  FoodItemsViewController.swift
//  InnoFest
//
//  Created by Ryan The on 19/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

class FoodItemsViewController: UIViewController {

	init(for stall: Stall) {
		super.init(nibName: nil, bundle: nil)
		self.title = stall.name
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        
    }
}
