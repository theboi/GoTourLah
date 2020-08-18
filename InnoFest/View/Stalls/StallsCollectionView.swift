//
//  StallsCollectionView.swift
//  InnoFest
//
//  Created by Ryan The on 15/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

class StallsCollectionView: UICollectionView, UICollectionViewDataSource {
	var viewController: StallsViewController!
	
	override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
		super.init(frame: frame, collectionViewLayout: layout)
		self.backgroundColor = .systemBackground
		self.dataSource = self
		self.register(StallsCollectionViewCell.self, forCellWithReuseIdentifier: "stallsCollectionViewCell")
		self.register(StallsCollectionReusableView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: "stallsCollectionViewCell")
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stallsCollectionViewCell", for: indexPath) as! StallsCollectionViewCell
		cell.titleLabel.text = "Title"
		
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let view = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "stallsCollectionViewCell", for: indexPath) as! StallsCollectionReusableView
		view.label.text = "Header"
		return view
	}
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 2
	}
}
