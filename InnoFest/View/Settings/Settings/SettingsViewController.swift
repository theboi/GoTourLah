//
//  MeViewController.swift
//  InnoFest
//
//  Created by Ryan The on 25/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

struct SettingsTableItem {
	//	var items: [MeTableNode?]
	var title: String
	var viewController: UIViewController?
	var accessoryView: UIView?
}

let defaultList = [
	[
		SettingsTableItem(title: "Account", viewController: SettingsViewController(list: [[
			SettingsTableItem(title: "Sign-In Again"),
			SettingsTableItem(title: "Is Enabled", accessoryView: UISwitch())
			]])),
	],
	[
		SettingsTableItem(title: "History", viewController: UIViewController()),
		SettingsTableItem(title: "Privacy", viewController: UIViewController()),
	],
]

class SettingsViewController: UITableViewController {
	
	var listData: [[SettingsTableItem]] = [[]]
	
	init(list: [[SettingsTableItem]]?) {
		super.init(nibName: nil, bundle: nil)
		self.title = "Settings"
		self.tableView = UITableView(frame: CGRect(), style: .insetGrouped)
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "settingsTableViewCell")
		self.listData = list ?? defaultList
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return listData.count
	}
	
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		return UIView()
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return listData[section].count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "settingsTableViewCell", for: indexPath)
		cell.textLabel?.text = listData[indexPath.section][indexPath.row].title
		if let accessoryView = listData[indexPath.section][indexPath.row].accessoryView {
			cell.accessoryView = accessoryView
		} else if listData[indexPath.section][indexPath.row].viewController != nil {
			cell.accessoryType = .disclosureIndicator
		}
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		guard let nextViewController = listData[indexPath.section][indexPath.row].viewController else {
			return
		}
		nextViewController.title = listData[indexPath.section][indexPath.row].title
		self.navigationController?.pushViewController(nextViewController, animated: true)
	}
}
