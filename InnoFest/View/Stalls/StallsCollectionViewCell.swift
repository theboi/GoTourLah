//
//  StallsCollectionViewCell.swift
//  InnoFest
//
//  Created by Ryan The on 17/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

class StallsCollectionViewCell: UICollectionViewCell {
	
	lazy var image = UIImage(named: "tempImage")
	lazy var titleLabel = UILabel()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.backgroundColor = .secondarySystemBackground
		self.layer.cornerRadius = 10
		self.clipsToBounds = true
		
		let imageView = UIImageView(image: image)
		self.addSubview(imageView)
		self.addConstraints([
			imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -50),
			imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
		])
		imageView.translatesAutoresizingMaskIntoConstraints = false
		
		let textView = UIView()
		self.addSubview(textView)
		self.addConstraints([
			textView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
			textView.heightAnchor.constraint(equalToConstant: 50),
			textView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
			textView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
		])
		textView.translatesAutoresizingMaskIntoConstraints = false
		
		titleLabel.font = .systemFont(ofSize: titleLabel.font.pointSize, weight: .semibold)
		textView.addSubview(titleLabel)
		textView.addConstraints([
			titleLabel.centerYAnchor.constraint(equalTo: textView.centerYAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 10),
			titleLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: 10),
		])
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
}
