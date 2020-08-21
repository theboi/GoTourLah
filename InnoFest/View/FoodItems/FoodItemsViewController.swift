//
//  FoodItemsViewController.swift
//  InnoFest
//
//  Created by Ryan The on 19/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

class FoodItemsViewController: UIViewController {
	
	let margin: CGFloat = 20

	var stall: Stall!

	lazy var collectionView = FoodItemsCollectionView(frame: CGRect(), collectionViewLayout: createGridLayout(), stall: self.stall)

	init(for stall: Stall) {
		super.init(nibName: nil, bundle: nil)
		self.stall = stall
		self.title = stall.name
		self.view.backgroundColor = .systemBackground
		
		self.view.addSubview(collectionView)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		self.view.addConstraints([
			collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
			collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
			collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
		])
		collectionView.viewController = self
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func createGridLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
			let itemSize = NSCollectionLayoutSize(widthDimension: .absolute((UIScreen.main.bounds.width-self.margin*3)/2), heightDimension: .fractionalHeight(1.0))
			
			let item = NSCollectionLayoutItem(layoutSize: itemSize)
			
			let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(220))
			
			let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
			group.interItemSpacing = NSCollectionLayoutSpacing.fixed(self.margin)
			
			let section = NSCollectionLayoutSection(group: group)
			section.interGroupSpacing = self.margin
			
			section.contentInsets = NSDirectionalEdgeInsets(top: self.margin, leading: self.margin, bottom: self.margin, trailing: self.margin)
			//			let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(self.supplementaryViewHeight))
			//			section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: "header", alignment: .top)]
			return section
		}
		return layout
	}
	
//	override func viewDidAppear(_ animated: Bool) {
//		UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
//		UIViewController.attemptRotationToDeviceOrientation()
//	}
//	
//	override func viewDidDisappear(_ animated: Bool) {
//		UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
//		UIViewController.attemptRotationToDeviceOrientation()
//	}
//	
//	override func responds(to aSelector: Selector!) -> Bool {
//		if (aSelector! == Selector(("canRotate"))) { return true }
//		return false
//	}
	
	func presentAddToCartViewController(indexPath: IndexPath) {
		let addToCartViewController = AddToCartViewController(stall: stall, foodItem: stall.foodItems[indexPath.row])
		self.navigationController?.present(addToCartViewController, animated: true)
	}
}
