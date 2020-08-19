////
////  StallsCollectionReusableView.swift
////  InnoFest
////
////  Created by Ryan The on 18/8/20.
////  Copyright © 2020 Ryan The. All rights reserved.
////
//
//import UIKit
//
//class StallsCollectionReusableView: UICollectionReusableView {
//	
//	lazy var label = UILabel()
//	
//	override init(frame: CGRect) {
//		super.init(frame: frame)
//		self.addSubview(label)
//		label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
//		label.translatesAutoresizingMaskIntoConstraints = false
//		self.addConstraints([
//			label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//			label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//			label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//		])
//	}
//	
//	required init?(coder: NSCoder) {
//		super.init(coder: coder)
//	}
//}
