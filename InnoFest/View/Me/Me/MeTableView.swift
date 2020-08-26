//
//  MeTableView.swift
//  InnoFest
//
//  Created by Ryan The on 25/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

struct MeTableNode {
	var header: String?
	var items: [MeTableNode?]
}

class MeTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
	
	let settingsHierarchy = [
		MeTableNode(header: "Header", items: [
			
		])
	]
	
	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		self.delegate = self
		self.dataSource = self
		self.register(UITableViewCell.self, forCellReuseIdentifier: "meTableViewCell")
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return settingsHierarchy.count
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = UILabel()
		header.text = "Hello"
		return header
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "meTableViewCell", for: indexPath)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
