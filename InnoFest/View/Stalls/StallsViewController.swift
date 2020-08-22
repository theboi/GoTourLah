//
//  ViewController.swift
//  InnoFest
//
//  Created by Ryan The on 1/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

class StallsViewController: UIViewController {
	
	let margin: CGFloat = 20
	
	lazy var collectionView = StallsCollectionView(frame: UIScreen.main.bounds, collectionViewLayout: createGridLayout())
	
	lazy var searchBar = UISearchBar()
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Stalls"
		self.view.backgroundColor = .systemBackground
		self.navigationItem.searchController = UISearchController()
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(presentCartViewController))
		self.view.addSubview(collectionView)
		collectionView.viewController = self
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
	
	@objc func presentCartViewController() {
		let cartViewController = CartViewController()
		let cartNavigationController = UINavigationController(rootViewController: cartViewController)
		self.navigationController?.present(cartNavigationController, animated: true, completion: nil)
	}
	
	func presentFoodItemsViewController(for stall: Stall) {
		let foodItemsViewController = FoodItemsViewController(for: stall)
		self.navigationController?.pushViewController(foodItemsViewController, animated: true)
	}
}

