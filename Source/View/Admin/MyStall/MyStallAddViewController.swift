//
//  MyStallAddViewController.swift
//  Barg-InnoFest
//
//  Created by Ryan The on 19/9/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

struct MyStallAddField {
    var name: String
    var placeholder: String
}

class MyStallAddViewController: ModalActionViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView = UITableView(frame: CGRect(), style: .insetGrouped)
    
    let myStallAddCellIdentifier = "myStallAddCell"
    
    let fields = [
        MyStallAddField(name: "Name", placeholder: "Chicken Rice"),
        MyStallAddField(name: "Description", placeholder: "Classical Singapore Hainanese Chicken Rice"),
        MyStallAddField(name: "Price", placeholder: "1.50"),
    ]
    
    @objc func createNewFoodItem() {
        
    }
    
    private func setupUi() {
        let headerLabel = UILabel()
        contentView.addSubview(headerLabel)
        headerLabel.text = "Add New Food Item"
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints([
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
        ])
        
        self.contentView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addConstraints([
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: K.marginCg)
        ])
    }
    
    // MARK: ModalActionTableViewController
    
    init() {
        super.init(actions: [ModalActionAction(title: "Add Food Item", action: #selector(createNewFoodItem), isPrimary: true)], target: nil)
        self.target = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(InputTableViewCell.self, forCellReuseIdentifier: myStallAddCellIdentifier)
        
        setupUi()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: myStallAddCellIdentifier, for: indexPath)
        cell.textLabel?.text = fields[indexPath.row].name
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return K.buttonHeight
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
