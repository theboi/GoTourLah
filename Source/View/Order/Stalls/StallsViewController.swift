//
//  StallsViewController.swift
//  Barg-InnoFest
//
//  Created by Ryan The on 12/9/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit
import GoogleSignIn

private let reuseIdentifier = "Cell"

class StallsViewController: UICollectionViewController, UISearchBarDelegate {

    var appDelegate = (UIApplication.shared.delegate) as! AppDelegate
    
    var searchString: String = ""
    
    lazy var searchController = UISearchController()

    var stallsData: [Stall] = [Stall(name: "hello", desc: "djwanjdn", model: .select, foodItems: [])]
    
    var filteredStallsData: [Stall] {
        return stallsData.filter { searchString == "" ? true : $0.name.lowercased().contains(searchString) }
    }
    
    func refreshStallsData() {
        appDelegate.firestoreDb?.collection(K.dbCollectionNames.foodItems).getDocuments(completion: { (querySnapshot, error) in
            if let error = error {
                fatalError("ERROR: %@ \(error)")
            }
            if let querySnapshot = querySnapshot, !querySnapshot.isEmpty {
                self.stallsData = Stall.fromQuerySnapshot(querySnapshot)
            }
        })
    }
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Order"
//        self.collectionView.backgroundColor = .none
        self.view.backgroundColor = .systemGroupedBackground
        self.navigationItem.searchController = searchController
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(presentCartViewController))
        self.view.addSubview(collectionView)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        self.collectionView.register(StallsCollectionViewCell.self, forCellWithReuseIdentifier: "stallsCollectionViewCell")
    }
    
    init() {
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
        
        super.init(collectionViewLayout: createGridLayout())
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredStallsData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stallsCollectionViewCell", for: indexPath) as! StallsCollectionViewCell
        cell.titleLabel.text = filteredStallsData[indexPath.row].name
        return cell
    }

    // MARK: UICollectionViewDelegate

    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presentFoodItemsViewController(for: filteredStallsData[indexPath.row])
    }
    
    
    // MARK: UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchString = searchText.lowercased()
        self.collectionView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchString = ""
        self.collectionView.reloadData()
    }
    
}
