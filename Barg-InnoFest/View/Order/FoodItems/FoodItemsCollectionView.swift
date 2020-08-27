//
//  FoodItemsCollectionView.swift
//  InnoFest
//
//  Created by Ryan The on 20/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

class FoodItemsCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {

	
	var viewController: FoodItemsViewController!
	var stall: Stall!
	
	init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, stall: Stall) {
		super.init(frame: frame, collectionViewLayout: layout)
		self.backgroundColor = .none
		self.stall = stall
		self.dataSource = self
		self.delegate = self
		self.register(FoodItemsCollectionViewCell.self, forCellWithReuseIdentifier: "foodItemsCollectionViewCell")
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return stall.foodItems.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodItemsCollectionViewCell", for: indexPath) as! FoodItemsCollectionViewCell
		cell.nameLabel.text = stall.foodItems[indexPath.row].name
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		self.viewController.presentAddToCartViewController(indexPath: indexPath)
	}
	
}
