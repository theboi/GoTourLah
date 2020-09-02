//
//  MeViewController.swift
//  Barg-InnoFest
//
//  Created by Ryan The on 25/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

struct SettingsTableItem {
    var title: String
    var image: UIImage?
    var height: CGFloat?
    var customCell: UITableViewCell?
    var accessoryView: UIView?
    var viewController: UIViewController?
}

let defaultList = [
    [
        SettingsTableItem(title: "Account", image: K.placeholderImage, height: 100, customCell: createProfileCell(), viewController: SettingsViewController(list: [[
            SettingsTableItem(title: "Sign-In Again"),
            SettingsTableItem(title: "Is Enabled", accessoryView: UISwitch()),
            SettingsTableItem(title: "Account", viewController: SettingsViewController(list: [[
                SettingsTableItem(title: "Sign-In Again"),
                SettingsTableItem(title: "Is Enabled", accessoryView: UISwitch())
            ]])),
        ]])),
    ],
//    [
//        SettingsTableItem(title: "History", viewController: UIViewController()),
//        SettingsTableItem(title: "Privacy", viewController: UIViewController()),
//    ],
]

func createProfileCell() -> UITableViewCell {
    let cell = SettingsProfileTableViewCell(style: .subtitle, reuseIdentifier: "settingsProfileTableViewCell")
    cell.detailTextLabel?.text = "email.address@gmail.com"
    return cell
}

class SettingsViewController: UITableViewController {
    
    var listData: [[SettingsTableItem]] = [[]]
    
    init(list: [[SettingsTableItem]]?) {
        super.init(nibName: nil, bundle: nil)
        self.title = "Settings"
        self.tableView = UITableView(frame: CGRect(), style: .insetGrouped)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "settingsTableViewCell")
        self.tableView.register(SettingsProfileTableViewCell.self, forCellReuseIdentifier: "settingsProfileTableViewCell")
        self.listData = list ?? defaultList
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return listData.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = listData[indexPath.section][indexPath.row]
        let cell = cellData.customCell ?? tableView.dequeueReusableCell(withIdentifier: "settingsTableViewCell", for: indexPath)
        cell.textLabel?.text = cellData.title
        if let accessoryView = cellData.accessoryView {
            cell.accessoryView = accessoryView
            cell.selectionStyle = .none
        } else if cellData.viewController != nil {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.selectionStyle = .none
        }
        cell.imageView?.image = cellData.image
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return listData[indexPath.section][indexPath.row].height ?? tableView.rowHeight
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
