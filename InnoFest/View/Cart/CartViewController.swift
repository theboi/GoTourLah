//
//  CartViewController.swift
//  InnoFest
//
//  Created by Ryan The on 15/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
	lazy var tableView = CartTableView(frame: UIScreen.main.bounds, style: .plain)
	
	lazy var searchBar = UISearchBar()
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.navigationBar.prefersLargeTitles = false
		self.title = "Cart"
		self.view.backgroundColor = .systemBackground
		self.navigationItem.searchController = UISearchController()
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissCartViewController))
		self.view.addSubview(tableView)
		tableView.viewController = self
	}
	
	func presentCartItemViewController() {
		let cartItemViewController = UIViewController()
		cartItemViewController.view.backgroundColor = .systemBackground
		self.navigationController?.pushViewController(cartItemViewController, animated: true)
	}
	
	@objc func dismissCartViewController() {
		self.dismiss(animated: true)
	}
}
