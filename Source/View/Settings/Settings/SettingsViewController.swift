//
//  MeViewController.swift
//  Barg-InnoFest
//
//  Created by Ryan The on 25/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

typealias SettingsAction = () -> Void
typealias SettingsList = () -> [[SettingsTableItem]]
struct SettingsTableItem {
    var title: String
    var image: UIImage?
    var height: CGFloat?
    var customCell: UITableViewCell?
    var accessoryView: UIView?
    var pushViewController: UIViewController?
    var presentViewController: UIViewController?
    var action: SettingsAction?
}

class SettingsViewController: UITableViewController {
    
    var listData: SettingsList!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var profileTableItem: SettingsTableItem {
        let cellHeight: CGFloat = 100
        let currentUser = Auth.auth().currentUser
        if let displayName = currentUser?.displayName {
            return SettingsTableItem(title: displayName, image: K.placeholderImage, height: cellHeight, customCell: createProfileCell(style: .subtitle), pushViewController: SettingsViewController(list: {[[
                SettingsTableItem(title: "Sign Out", action: {
                    UserAuth.signOut()
                    self.navigationController?.popToRootViewController(animated: true)
                }),
            ]]}))
        } else {
            return SettingsTableItem(title: "Sign In With Google", image: UIImage(named: "ProfilePlaceholder"), height: cellHeight, customCell: createProfileCell(style: .default), action: UserAuth.signIn)
        }
    }
    
    var adminConsole: () -> [SettingsTableItem] {
        { () -> [SettingsTableItem] in
            if self.appDelegate.admin.isAdmin {
                return [
                    SettingsTableItem(title: "Admin Mode", accessoryView: self.createAdminSwitch()),
                ]
            }
            return []
        }
    }
    
    var defaultList: SettingsList {
        { () -> [[SettingsTableItem]] in
            return [
                [
                    self.profileTableItem,
                ],
                [
                    SettingsTableItem(title: "History", pushViewController: UIViewController()),
                    SettingsTableItem(title: "Privacy", presentViewController: { () -> UIAlertController in
                        let privacyAlert = UIAlertController(title: "Privacy", message: "Your data will be kept private and confidential... hopefully...", preferredStyle: .alert)
                        privacyAlert.addAction(UIAlertAction(title: "OK", style: .default))
                        return privacyAlert
                    }()),
                ],
                self.adminConsole()
            ]
        }
    }
    
    @objc func toggleAdminMode(sender: UISwitch) {
        appDelegate.admin.isAdminModeOn = sender.isOn
        NotificationCenter.default.post(Notification(name: .AdminModeDidChange))
    }
    
    func createAdminSwitch() -> UISwitch {
        let adminSwitch = UISwitch()
        adminSwitch.addTarget(self, action: #selector(toggleAdminMode(sender:)), for: .touchUpInside)
        return adminSwitch
    }
    
    func createProfileCell(style: SettingsProfileTableViewCell.CellStyle) -> UITableViewCell {
        let cell = SettingsProfileTableViewCell(style: style, reuseIdentifier: "settingsProfileTableViewCell")
        let currentUser = Auth.auth().currentUser
        cell.detailTextLabel?.text = currentUser?.email
        return cell
    }
    
    init(list: SettingsList?) {
        super.init(nibName: nil, bundle: nil)
        self.title = "Settings"
        self.tableView = UITableView(frame: CGRect(), style: .insetGrouped)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "settingsTableViewCell")
        self.tableView.register(SettingsProfileTableViewCell.self, forCellReuseIdentifier: "settingsProfileTableViewCell")
        self.listData = list ?? defaultList
        NotificationCenter.default.addObserver(self, selector: #selector(authStateDidChange(notification:)), name: .AuthStateDidChange, object: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func authStateDidChange(notification: NSNotification) {
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return listData().count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData()[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellData = listData()[indexPath.section][indexPath.row]
        let cell = cellData.customCell ?? tableView.dequeueReusableCell(withIdentifier: "settingsTableViewCell", for: indexPath)
        
        cell.textLabel?.text = cellData.title
        if let accessoryView = cellData.accessoryView {
            cell.accessoryView = accessoryView
            cell.selectionStyle = .none
        } else if cellData.pushViewController != nil || cellData.presentViewController != nil {
            cell.accessoryType = .disclosureIndicator
        } else if cellData.action != nil {
        } else {
            cell.selectionStyle = .none
        }
        cell.imageView?.image = cellData.image
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return listData()[indexPath.section][indexPath.row].height ?? tableView.rowHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData = listData()[indexPath.section][indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        cellData.action?()
        if let nextViewController = cellData.pushViewController {
            nextViewController.title = cellData.title
            self.navigationController?.pushViewController(nextViewController, animated: true)
        } else if let nextViewController = cellData.presentViewController {
            self.navigationController?.present(nextViewController, animated: true)
        }
    }
}