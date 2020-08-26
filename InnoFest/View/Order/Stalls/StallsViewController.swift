//
//  ViewController.swift
//  InnoFest
//
//  Created by Ryan The on 1/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

class StallsViewController: UIViewController, UISearchBarDelegate {
		
	lazy var collectionView = StallsCollectionView(frame: UIScreen.main.bounds, collectionViewLayout: createGridLayout())
	
	lazy var searchController = UISearchController()
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Order"
		self.view.backgroundColor = .systemBackground
		self.navigationItem.searchController = searchController
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(presentCartViewController))
		collectionView.viewController = self
		self.view.addSubview(collectionView)
		searchController.searchBar.delegate = self
		searchController.obscuresBackgroundDuringPresentation = false
	}
	
	func createGridLayout() -> UICollectionViewLayout {
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
	
	@objc func presentCartViewController() {
		let cartViewController = CartViewController()
		let cartNavigationController = UINavigationController(rootViewController: cartViewController)
		self.navigationController?.present(cartNavigationController, animated: true, completion: nil)
	}
	
	func presentFoodItemsViewController(for stall: Stall) {
		let foodItemsViewController = FoodItemsViewController(for: stall)
		self.navigationController?.pushViewController(foodItemsViewController, animated: true)
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		collectionView.searchString = searchText.lowercased()
		collectionView.reloadData()
	}
	
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		collectionView.searchString = ""
		collectionView.reloadData()
	}
}

