//
//  FoodItemsViewController.swift
//  Barg-InnoFest
//
//  Created by Ryan The on 19/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

class FoodItemsViewController: UIViewController {
	
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
	
	private func createGridLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute((UIScreen.main.bounds.width-K.marginCg*3)/2), heightDimension: .fractionalHeight(1.0))
			
			let item = NSCollectionLayoutItem(layoutSize: itemSize)
			
			let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(220))
			
			let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
			group.interItemSpacing = NSCollectionLayoutSpacing.fixed(K.marginCg)
			
			let section = NSCollectionLayoutSection(group: group)
			section.interGroupSpacing = K.marginCg
			
			section.contentInsets = NSDirectionalEdgeInsets(top: K.marginCg, leading: K.marginCg, bottom: K.marginCg, trailing: K.marginCg)
			return section
		}
		return layout
	}
    
    func presentAddToCartViewController(indexPath: IndexPath) {
		let addToCartViewController = AddToCartViewController(stall: stall, foodItem: stall.foodItems[indexPath.row])
		let navigationController = UINavigationController(rootViewController: addToCartViewController)
		addToCartViewController.foodItemsViewController = self
		self.navigationController?.present(navigationController, animated: true)
	}
}
