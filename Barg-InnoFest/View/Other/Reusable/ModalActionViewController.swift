//
//  ModalActionViewController.swift
//  Barg-InnoFest
//
//  Created by Ryan The on 1/9/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

struct IntroAction {
    var title: String
    var action: Selector
    var image: UIImage?
    var isPrimary: Bool? = false
}

class ModalActionViewController: UIViewController {

    var contentView: UIView!
    var actions: [IntroAction]!
    var target: Any?
    
    init(contentView: UIView? = UIView(), actions: [IntroAction], target: Any?) {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .systemBackground
        self.contentView = contentView
        self.actions = actions
        self.target = target
        
        setupUi()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUi() {
        let actionButtons = actions?.map { (introAction) -> UIButton in
            let button = UIButton(type: .roundedRect)
            button.backgroundColor = introAction.isPrimary! ? .link : .none
            button.tintColor = introAction.isPrimary! ? .white : .link
            button.setTitle(introAction.title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: button.titleLabel!.font.pointSize, weight: introAction.isPrimary! ? .medium : .regular)
            button.addTarget(target, action: introAction.action, for: .touchUpInside)
            button.heightAnchor.constraint(equalToConstant: K.buttonHeight).isActive = true
            button.layer.cornerRadius = K.cornerRadiusCg
            if let image = introAction.image {
                button.setImage(image, for: .normal)
                button.imageEdgeInsets.right += 10
                button.titleEdgeInsets.left = 10
            }
            return button
        }
        
        let stackView = UIStackView(arrangedSubviews: actionButtons!)
        self.view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints([
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: K.marginCg),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -K.marginCg),
            stackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -K.marginCg),
        ])
        
        if let contentView = contentView {
            self.view.addSubview(contentView)
            contentView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addConstraints([
                contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -K.marginCg),
                contentView.topAnchor.constraint(equalTo: self.view.topAnchor),
            ])
        }
        
    }
}
