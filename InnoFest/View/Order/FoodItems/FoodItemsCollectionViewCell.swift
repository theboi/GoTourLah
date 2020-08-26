//
//  FoodItemsCollectionViewCell.swift
//  InnoFest
//
//  Created by Ryan The on 21/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

class FoodItemsCollectionViewCell: UICollectionViewCell {
	lazy var image = K.placeholderImage
	lazy var nameLabel = UILabel()
	lazy var priceLabel = UILabel()
	lazy var descLabel = UILabel()

	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.backgroundColor = .secondarySystemBackground
		self.layer.cornerRadius = K.cornerRadiusCg
		self.layer.borderWidth = K.borderWidthCg
		self.layer.borderColor = UIColor.systemFill.cgColor
		self.clipsToBounds = true
		
		let imageView = UIImageView(image: image)
		self.addSubview(imageView)
		self.addConstraints([
			imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -100),
			imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
		])
		imageView.translatesAutoresizingMaskIntoConstraints = false
		
		let textView = UIView()
		self.addSubview(textView)
		self.addConstraints([
			textView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
			textView.heightAnchor.constraint(equalToConstant: 100),
			textView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
			textView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
		])
		textView.translatesAutoresizingMaskIntoConstraints = false
		
		nameLabel.font = .systemFont(ofSize: nameLabel.font.pointSize, weight: .semibold)
		textView.addSubview(nameLabel)
		textView.addConstraints([
			nameLabel.centerYAnchor.constraint(equalTo: textView.centerYAnchor),
			nameLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 10),
			nameLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: 10),
		])
		nameLabel.translatesAutoresizingMaskIntoConstraints = false
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
}
