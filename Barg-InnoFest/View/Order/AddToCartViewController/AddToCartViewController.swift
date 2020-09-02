//
//  AddToCartViewController.swift
//  Barg-InnoFest
//
//  Created by Ryan The on 21/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

class AddToCartViewController: ModalActionViewController {
	
	var image: UIImage!
	var stall: Stall!
	var foodItem: FoodItem!
	var foodItemsViewController: FoodItemsViewController!

	init(stall: Stall, foodItem: FoodItem) {
		super.init(actions: [
            IntroAction(title: "Add To Cart", action: #selector(addToCart), image: UIImage(systemName: "cart.badge.plus"), isPrimary: true)
        ], target: nil)
        self.target = self
		self.stall = stall
		self.foodItem = foodItem
		self.view.backgroundColor = .systemBackground
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissCartViewController))
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: getIsFavorite() ? "heart.fill" : "heart"), style: .plain, target: self, action: #selector(toggleFavorite))
        
		setupUi()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	private func setupUi() {
		image = K.placeholderImage
		let imageView = UIImageView(image: image)
		self.contentView.addSubview(imageView)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.addConstraints([
			imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
			imageView.heightAnchor.constraint(equalToConstant: 400),
		])

		let imageBottomGradient = GradientView(topColor: .clear, bottomColor: UIScreen.main.traitCollection.userInterfaceStyle == .dark ? .secondarySystemBackground : .black)
		self.contentView.addSubview(imageBottomGradient)
		imageBottomGradient.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.addConstraints([
			imageBottomGradient.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
			imageBottomGradient.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
			imageBottomGradient.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
			imageBottomGradient.heightAnchor.constraint(equalToConstant: 150),
		])

		let imageTopGradient = GradientView(topColor: .secondarySystemBackground, bottomColor: .clear)
		self.contentView.addSubview(imageTopGradient)
		imageTopGradient.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.addConstraints([
			imageTopGradient.topAnchor.constraint(equalTo: imageView.topAnchor),
			imageTopGradient.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
			imageTopGradient.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
			imageTopGradient.heightAnchor.constraint(equalToConstant: 150),
		])

		let spacer = UIView()
		spacer.setContentHuggingPriority(.defaultLow, for: .vertical)

		let titleLabel = UILabel()
		titleLabel.text = foodItem.name
		titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .semibold)

		let priceLabel = UILabel()
		priceLabel.text = "S$" + String(format: "%.2f", foodItem.price)
		priceLabel.textColor = .secondaryLabel
		priceLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)

		let descLabel = UILabel()
		descLabel.text = foodItem.desc
		descLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)

		let detailsStackView = UIStackView(arrangedSubviews: [titleLabel, priceLabel, descLabel, spacer])
		detailsStackView.axis = .vertical
		detailsStackView.spacing = 10
		self.contentView.addSubview(detailsStackView)
		detailsStackView.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.addConstraints([
            detailsStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            detailsStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
			detailsStackView.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: K.marginCg),
			detailsStackView.trailingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.trailingAnchor, constant: -K.marginCg),
		])
	}

	@objc private func dismissCartViewController() {
		self.dismiss(animated: true)
	}

	@objc func addToCart() {
		Cart.addToCart(foodItem: foodItem, fromStall: stall)
		self.contentView.window?.presentToast(message: "Added to Cart 🛒")
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			self.foodItemsViewController?.navigationController?.popToRootViewController(animated: true)
			self.dismiss(animated: true)
		}
	}

	@objc private func toggleFavorite() {
		if (UserDefaults.standard.array(forKey: "favorites") == nil) {
			UserDefaults.standard.set([], forKey: "favorites")
		}
		let favorites = UserDefaults.standard.array(forKey: "favorites")! as! [String]
		var newFavorites = favorites
		if favorites.contains(where: { $0 == "\(foodItem.stallName): \(foodItem.name)" }) {
			newFavorites.removeAll { $0 == "\(foodItem.stallName): \(foodItem.name)" }
		} else {
			newFavorites.append("\(foodItem.stallName): \(foodItem.name)")
		}
		UserDefaults.standard.set(newFavorites, forKey: "favorites")
		self.navigationItem.leftBarButtonItem?.image = UIImage(systemName: getIsFavorite() ? "heart.fill" : "heart")
	}

	private func getIsFavorite() -> Bool {
		if (UserDefaults.standard.array(forKey: "favorites") == nil) {
			UserDefaults.standard.set([], forKey: "favorites")
		}
		let favorites = UserDefaults.standard.array(forKey: "favorites")! as! [String]
		return favorites.contains { $0 == "\(foodItem.stallName): \(foodItem.name)" }
	}
}
