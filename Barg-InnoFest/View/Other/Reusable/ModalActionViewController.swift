//
//  WhatsNewViewController.swift
//  Barg-InnoFest
//
//  Created by Ryan The on 1/9/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

struct IntroAction {
    var title: String
    var action: Selector
    var isPrimary: Bool? = false
}

class ModalActionViewController: UIViewController {

    init(title: String, actions: [IntroAction], target: Any?, contentView: UIView? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .systemBackground
        self.isModalInPresentation = true
        
        let headerLabel = UILabel()
        self.view.addSubview(headerLabel)
        headerLabel.text = title
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            headerLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            headerLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
        ])
        
        let actionButtons = actions.map { (introAction) -> UIButton in
            let button = UIButton(type: .roundedRect)
            button.backgroundColor = introAction.isPrimary! ? .link : .none
            button.tintColor = introAction.isPrimary! ? .white : .link
            button.setTitle(introAction.title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: button.titleLabel!.font.pointSize, weight: introAction.isPrimary! ? .medium : .regular)
            button.addTarget(target, action: introAction.action, for: .touchUpInside)
            button.heightAnchor.constraint(equalToConstant: K.buttonHeight).isActive = true
            button.layer.cornerRadius = K.cornerRadiusCg
            return button
        }
        let stackView = UIStackView(arrangedSubviews: actionButtons)
        self.view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: K.marginCg),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -K.marginCg),
            stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -K.marginCg),
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
