//
//  AddToCartViewController.swift
//  InnoFest
//
//  Created by Ryan The on 21/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

class AddToCartViewController: UIViewController {

	var image: UIImage!
	
	init(stall: Stall, foodItem: FoodItem) {
		super.init(nibName: nil, bundle: nil)
		self.view.backgroundColor = .systemBackground
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissCartViewController))
		
		image = K.placeholderImage
		let imageView = UIImageView(image: image)
		self.view.addSubview(imageView)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		self.view.addConstraints([
			imageView.topAnchor.constraint(equalTo: self.view.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
			imageView.heightAnchor.constraint(equalToConstant: 400),
		])
		
		let imageBottomGradient = GradientView(topColor: .clear, bottomColor: .secondarySystemBackground)
		self.view.addSubview(imageBottomGradient)
		imageBottomGradient.translatesAutoresizingMaskIntoConstraints = false
		self.view.addConstraints([
			imageBottomGradient.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
			imageBottomGradient.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			imageBottomGradient.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
			imageBottomGradient.heightAnchor.constraint(equalToConstant: 150),
		])
		
		let imageTopGradient = GradientView(topColor: .secondarySystemBackground, bottomColor: .clear)
		self.view.addSubview(imageTopGradient)
		imageTopGradient.translatesAutoresizingMaskIntoConstraints = false
		self.view.addConstraints([
			imageTopGradient.topAnchor.constraint(equalTo: imageView.topAnchor),
			imageTopGradient.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			imageTopGradient.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
			imageTopGradient.heightAnchor.constraint(equalToConstant: 150),
		])
		
		let addToCartButton = UIButton(type: .roundedRect)
		self.view.addSubview(addToCartButton)
		addToCartButton.backgroundColor = K.tintColor
		addToCartButton.tintColor = .white
		addToCartButton.layer.cornerRadius = K.cornerRadiusCg
		addToCartButton.setTitle("Add To Cart", for: .normal)
		addToCartButton.translatesAutoresizingMaskIntoConstraints = false
		self.view.addConstraints([
			addToCartButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -K.marginCg),
			addToCartButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: K.marginCg),
			addToCartButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -K.marginCg),
			addToCartButton.heightAnchor.constraint(equalToConstant: 50),
		])
		addToCartButton.addTarget(self, action: #selector(onAddToCartPress), for: .touchUpInside)
		
		let spacer = UIView()
		spacer.setContentHuggingPriority(.defaultLow, for: .vertical)

		let titleLabel = UILabel()
		titleLabel.text = foodItem.name
		titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
		
		let priceLabel = UILabel()
		priceLabel.text = String(foodItem.price)
		priceLabel.textColor = .secondaryLabel
		priceLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
		
		let descLabel = UILabel()
		descLabel.text = foodItem.desc
		descLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
		
		let detailsStackView = UIStackView(arrangedSubviews: [titleLabel, priceLabel, descLabel, spacer])
		detailsStackView.axis = .vertical
		detailsStackView.spacing = 10
		self.view.addSubview(detailsStackView)
		detailsStackView.translatesAutoresizingMaskIntoConstraints = false
		self.view.addConstraints([
			detailsStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
			detailsStackView.bottomAnchor.constraint(equalTo: addToCartButton.topAnchor, constant: -40),
			detailsStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: K.marginCg),
			detailsStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -K.marginCg),
		])

	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	@objc func dismissCartViewController() -> Void {
		self.dismiss(animated: true)
	}
	
	@objc func onAddToCartPress() -> Void {
		// TODO: Add stuff here
		self.dismiss(animated: true)
	}
}
