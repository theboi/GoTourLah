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
		
		let addToCartButton = UIButton(type: .roundedRect)
		self.view.addSubview(addToCartButton)
		addToCartButton.backgroundColor = .link
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
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	@objc func dismissCartViewController() {
		self.dismiss(animated: true)
	}
}
