//
//  UIWindow.swift
//  InnoFest
//
//  Created by Ryan The on 24/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

extension UIWindow {
    
    func presentToast(message: String, duration: Double = 0.5, delay: Double = 4.0) {
        let toastLabel = UILabel()
        self.addSubview(toastLabel)
        toastLabel.backgroundColor = .tertiarySystemGroupedBackground
        toastLabel.textColor = .label
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.layer.borderColor = UIColor.systemFill.cgColor
        toastLabel.layer.borderWidth = K.borderWidthCg
        toastLabel.layer.cornerRadius = 25
        toastLabel.clipsToBounds = true
        toastLabel.sizeToFit()
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([
            toastLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 100),
            toastLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            toastLabel.widthAnchor.constraint(equalToConstant: toastLabel.frame.width + K.marginCg*2*2),
            toastLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
        toastLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                
        func animateAway() {
            UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut], animations: {
                toastLabel.transform = CGAffineTransform(translationX: 0, y: 230).scaledBy(x: 0.8, y: 0.8)
            })
        }
        
        let swipeGestureRecogniser = UISwipeGestureRecognizer()
        swipeGestureRecogniser.direction = .down
        toastLabel.addGestureRecognizer(swipeGestureRecogniser) { (sender) -> Void in
            animateAway()
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseInOut], animations: {
            toastLabel.transform = CGAffineTransform(translationX: 0, y: -230).scaledBy(x: 1.0, y: 1.0)
        }, completion: {_ in
            Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in animateAway()}
        })
    }
}
