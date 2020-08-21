//
//  StallsCollectionView.swift
//  InnoFest
//
//  Created by Ryan The on 15/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

class StallsCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
	var viewController: StallsViewController!
//	let headers = ["Favourites", "Stalls"]
	var stalls = [
		Stall(name: "Chinese Noodles", description: "Overpriced delicious food!", model: .set, isFavourite: false, foodItems: [FoodItem(name: "Chicken Rice", price: 1.00), FoodItem(name: "Prawn Noodles", price: 2.00)]),
		Stall(name: "Chinese Noodles", description: "Overpriced delicious food!", model: .set, isFavourite: false, foodItems: [FoodItem(name: "Chicken Rice", price: 1.00), FoodItem(name: "Prawn Noodles", price: 2.00)]),
		Stall(name: "Chinese Noodles", description: "Overpriced delicious food!", model: .set, isFavourite: false, foodItems: [FoodItem(name: "Chicken Rice", price: 1.00), FoodItem(name: "Prawn Noodles", price: 2.00)]),
		Stall(name: "Chinese Noodles", description: "Overpriced delicious food!", model: .set, isFavourite: false, foodItems: [FoodItem(name: "Chicken Rice", price: 1.00), FoodItem(name: "Prawn Noodles", price: 2.00)]),
		Stall(name: "Chinese Noodles", description: "Overpriced delicious food!", model: .set, isFavourite: false, foodItems: [FoodItem(name: "Chicken Rice", price: 1.00), FoodItem(name: "Prawn Noodles", price: 2.00)]),
		Stall(name: "Chinese Noodles", description: "Overpriced delicious food!", model: .set, isFavourite: false, foodItems: [FoodItem(name: "Chicken Rice", price: 1.00), FoodItem(name: "Prawn Noodles", price: 2.00)]),
	]
	
	override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
		super.init(frame: frame, collectionViewLayout: layout)
		self.backgroundColor = .none
		self.dataSource = self
		self.delegate = self
		self.register(StallsCollectionViewCell.self, forCellWithReuseIdentifier: "stallsCollectionViewCell")
//		self.register(StallsCollectionReusableView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: "stallsCollectionViewCell")
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return stalls.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stallsCollectionViewCell", for: indexPath) as! StallsCollectionViewCell
		cell.titleLabel.text = stalls[indexPath.row].name
		
		return cell
	}
	
//	func numberOfSections(in collectionView: UICollectionView) -> Int {
//		return 1
//	}
//
//	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//		let view = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "stallsCollectionViewCell", for: indexPath) as! StallsCollectionReusableView
//		view.label.text = headers[indexPath.section]
//		return view
//	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		viewController.presentFoodItemsViewController(for: stalls[indexPath.row])
	}
}
