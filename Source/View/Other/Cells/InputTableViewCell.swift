//
//  InputTableViewCell.swift
//  Barg-InnoFest
//
//  Created by Ryan The on 19/9/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

class InputTableViewCell: UITableViewCell {

    lazy private var inputField: UITextField = {
        let inputField = UITextField()
        inputField.textAlignment = .right
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputField.addTarget(self, action: #selector(inputFieldDidChange), for: .editingChanged)
        return inputField
    }()
    
    @objc func inputFieldDidChange() {
        
    }
    
    // MARK: UITableViewCell
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(inputField)
        self.addConstraints([
            inputField.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            inputField.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            inputField.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: UIResponder
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        inputField.becomeFirstResponder()
    }
    
}
