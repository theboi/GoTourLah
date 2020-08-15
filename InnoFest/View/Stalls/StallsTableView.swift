//
//  MainTableView.swift
//  CrudApp
//
//  Created by Ryan The on 1/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

class StallsTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

	var parent: StallsViewController!
	
	private let data = [Stall(named: "Chinese Rice")]
	
	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		self.delegate = self
		self.dataSource = self
		self.register(StallsTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath)
		
		// Configure the cell’s contents.
		cell.textLabel!.text = data[indexPath.row].name
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		parent.presentView()
	}
	
}
