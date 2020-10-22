//
//  ExploreViewCell.swift
//  Barg-InnoFest
//
//  Created by Ryan The on 21/10/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

class ExploreChallengeViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .secondarySystemGroupedBackground
        self.layer.cornerRadius = K.cornerRadius
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
