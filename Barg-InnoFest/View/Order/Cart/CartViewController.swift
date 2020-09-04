//
//  CartViewController.swift
//  Barg-InnoFest
//
//  Created by Ryan The on 15/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

class CartViewController: ModalActionViewController {
    var tableView = CartTableView(frame: CGRect(), style: .insetGrouped)
		
    init() {
        super.init(actions: [
            ModalActionAction(title: "Proceed To Payment", action: #selector(proceedToPayment), image: UIImage(systemName: "dollarsign.circle"), isPrimary: true),
        ], target: nil)
        self.target = self
        self.title = "Cart"
        self.view.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissCartViewController))
        setupUi()
    }
    
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
    private func setupUi() {
        self.contentView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addConstraints([
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
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
    
    @objc func proceedToPayment() {
        
    }
}
