//
//  ExploreViewController.swift
//  Barg-InnoFest
//
//  Created by Ryan The on 21/10/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

enum LayoutGroupType {
    case horizontal, vertical
}

struct SectionDetails {
    var name: String
    var layoutType: LayoutGroupType
}

private let cellReuseIdentifier = "cellReuseIdentifier"
private let headerReuseIdentifier = "headerReuseIdentifier"

private let sections = [
    SectionDetails(name: "Challenges", layoutType: .horizontal),
    SectionDetails(name: "Tours", layoutType: .vertical),
]

class ExploreViewController: UICollectionViewController {
    
    
    
    init() {
        let createGridLayout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            var itemSize: NSCollectionLayoutSize
            var groupSize: NSCollectionLayoutSize
            var scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .none
            
            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
            
            switch sections[sectionIndex].layoutType {
            case .horizontal:
                itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
                groupSize = NSCollectionLayoutSize(widthDimension: .absolute(UIScreen.main.bounds.width-K.margin*3), heightDimension: .absolute(270))
                scrollBehavior = .continuous
            case .vertical:
                itemSize = NSCollectionLayoutSize(widthDimension: .absolute((UIScreen.main.bounds.width-K.margin*3)/2), heightDimension: .fractionalHeight(1.0))
                groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(220))
            }
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = NSCollectionLayoutSpacing.fixed(K.margin)
            
            let section = NSCollectionLayoutSection(group: group)

            let headerLayout = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: headerReuseIdentifier, alignment: .top)
            
            section.boundarySupplementaryItems = [headerLayout]
            section.interGroupSpacing = K.margin
            section.supplementariesFollowContentInsets = true
            section.contentInsets = NSDirectionalEdgeInsets(top: K.margin, leading: K.margin, bottom: K.margin, trailing: K.margin)
            section.orthogonalScrollingBehavior = scrollBehavior
            return section
        }
        super.init(collectionViewLayout: createGridLayout)
        
        self.collectionView.backgroundColor = .systemGroupedBackground
        self.collectionView?.register(ExploreChallengeViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: headerReuseIdentifier, withReuseIdentifier: headerReuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: headerReuseIdentifier, withReuseIdentifier: headerReuseIdentifier, for: indexPath)
        
        let label = UILabel()
        view.addSubview(label)
        label.text = sections[indexPath.section].name
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        return view
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
