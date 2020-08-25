//
//  StallsCollectionView.swift
//  InnoFest
//
//  Created by Ryan The on 15/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

class StallsCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
	var searchString: String = ""
	
	var viewController: StallsViewController!
	var stallsData = [
		Stall(name: "Chinese Rice", desc: "Yummy overpriced food", model: .set, foodItems: [
			FoodItem(name: "Chicken w Veg", desc: "Uhh some desc here", price: 1.00, isFavourite: false, stallName: "Chicken Rice"),
			FoodItem(name: "Chicken w Veg", desc: "Uhh some desc here", price: 1.00, isFavourite: false, stallName: "Chicken Rice"),
			FoodItem(name: "Chicken w Veg", desc: "Uhh some desc here", price: 1.00, isFavourite: false, stallName: "Chicken Rice"),
		]),
		Stall(name: "Chinese Rice", desc: "Yummy overpriced food", model: .set, foodItems: [
			FoodItem(name: "Chicken w Veg", desc: "Uhh some desc here", price: 1.00, isFavourite: false, stallName: "Chicken Rice"),
			FoodItem(name: "Chicken w Veg", desc: "Uhh some desc here", price: 1.00, isFavourite: false, stallName: "Chicken Rice"),
			FoodItem(name: "Chicken w Veg", desc: "Uhh some desc here", price: 1.00, isFavourite: false, stallName: "Chicken Rice"),
		]),
		Stall(name: "Chinese Rice", desc: "Yummy overpriced food", model: .set, foodItems: [
			FoodItem(name: "Chicken w Veg", desc: "Uhh some desc here", price: 1.00, isFavourite: false, stallName: "Chicken Rice"),
			FoodItem(name: "Chicken w Veg", desc: "Uhh some desc here", price: 1.00, isFavourite: false, stallName: "Chicken Rice"),
			FoodItem(name: "Chicken w Veg", desc: "Uhh some desc here", price: 1.00, isFavourite: false, stallName: "Chicken Rice"),
		]),
		Stall(name: "Chinese Rice", desc: "Yummy overpriced food", model: .set, foodItems: [
			FoodItem(name: "Chicken w Veg", desc: "Uhh some desc here", price: 1.00, isFavourite: false, stallName: "Chicken Rice"),
			FoodItem(name: "Chicken w Veg", desc: "Uhh some desc here", price: 1.00, isFavourite: false, stallName: "Chicken Rice"),
			FoodItem(name: "Chicken w Veg", desc: "Uhh some desc here", price: 1.00, isFavourite: false, stallName: "Chicken Rice"),
		]),
		Stall(name: "Chinese Rice", desc: "Yummy overpriced food", model: .set, foodItems: [
			FoodItem(name: "Chicken w Veg", desc: "Uhh some desc here", price: 1.00, isFavourite: false, stallName: "Chicken Rice"),
			FoodItem(name: "Chicken w Veg", desc: "Uhh some desc here", price: 1.00, isFavourite: false, stallName: "Chicken Rice"),
			FoodItem(name: "Chicken w Veg", desc: "Uhh some desc here", price: 1.00, isFavourite: false, stallName: "Chicken Rice"),
		]),
		Stall(name: "Chinese Noodles", desc: "Yummy overpriced food", model: .set, foodItems: [
			FoodItem(name: "Chicken w Veg", desc: "Uhh some desc here", price: 1.00, isFavourite: false, stallName: "Chicken Rice"),
			FoodItem(name: "Chicken w Veg", desc: "Uhh some desc here", price: 1.00, isFavourite: false, stallName: "Chicken Rice"),
			FoodItem(name: "Chicken w Veg", desc: "Uhh some desc here", price: 1.00, isFavourite: false, stallName: "Chicken Rice"),
		]),
	]
	
	var filteredStallsData: [Stall] {
		return stallsData.filter { searchString == "" ? true : $0.name.contains(searchString) }
	}
	
	override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
		super.init(frame: frame, collectionViewLayout: layout)
		self.backgroundColor = .none
		self.dataSource = self
		self.delegate = self
		self.register(StallsCollectionViewCell.self, forCellWithReuseIdentifier: "stallsCollectionViewCell")
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return filteredStallsData.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stallsCollectionViewCell", for: indexPath) as! StallsCollectionViewCell
		cell.titleLabel.text = filteredStallsData[indexPath.row].name
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		viewController.presentFoodItemsViewController(for: filteredStallsData[indexPath.row])
	}
}
