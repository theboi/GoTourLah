//
//  ViewController.swift
//  CrudApp
//
//  Created by Ryan The on 1/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

class StallsViewController: UIViewController {
	
	let margin: CGFloat = 20
	let supplementaryViewHeight: CGFloat = 44
	
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
		self.navigationController?.navigationBar.prefersLargeTitles = true
		self.title = "Stalls"
		self.view.backgroundColor = .systemBackground
		self.navigationItem.searchController = UISearchController()
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(presentCartViewController))
		self.view.addSubview(collectionView)
		collectionView.viewController = self
	}
	
	func presentView() {
		let newVC = UIViewController()
		newVC.view.backgroundColor = .systemBackground
		self.navigationController?.pushViewController(newVC, animated: true)
	}
	
	@objc func presentCartViewController() {
		let cartViewController = CartViewController()
		let cartNavigationController = UINavigationController(rootViewController: cartViewController)
		cartViewController.view.backgroundColor = .systemBackground
		cartViewController.navigationController?.navigationBar.prefersLargeTitles = false
		cartViewController.title = "Cart"
		self.navigationController?.present(cartNavigationController, animated: true, completion: nil)
	}
	
	func createGridLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
			switch (sectionIndex) {
			case 0:
				let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
				
				let item = NSCollectionLayoutItem(layoutSize: itemSize)
				
				let groupSize = NSCollectionLayoutSize(widthDimension: .absolute((UIScreen.main.bounds.width-self.margin*3)/2), heightDimension: .absolute(130+44))
				
				let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
				
				let section = NSCollectionLayoutSection(group: group)
				section.interGroupSpacing = self.margin
				section.contentInsets = NSDirectionalEdgeInsets(top: self.margin, leading: self.margin, bottom: self.margin, trailing: self.margin)
				section.orthogonalScrollingBehavior = .continuous
				let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(self.supplementaryViewHeight))
				section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: "header", alignment: .top)]
				
				return section
			case 1:
				let itemSize = NSCollectionLayoutSize(widthDimension: .absolute((UIScreen.main.bounds.width-self.margin*3)/2), heightDimension: .fractionalHeight(1.0))
				
				let item = NSCollectionLayoutItem(layoutSize: itemSize)
				
				let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
				
				let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
				group.interItemSpacing = NSCollectionLayoutSpacing.fixed(self.margin)
				
				let section = NSCollectionLayoutSection(group: group)
				section.interGroupSpacing = self.margin

				section.contentInsets = NSDirectionalEdgeInsets(top: self.margin, leading: self.margin, bottom: self.margin, trailing: self.margin)
				let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(self.supplementaryViewHeight))
				section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: "header", alignment: .top)]
				return section
			default:
				fatalError("Collection index overflow or invalid.")
			}
		}
		
		return layout
	}
	
	func presentFoodItemsViewController(for stall: Stall) {
		let foodItemsViewController = FoodItemsViewController(for: stall)
		foodItemsViewController.view.backgroundColor = .systemBackground
		self.navigationController?.pushViewController(foodItemsViewController, animated: true)
	}
}

