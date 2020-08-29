//
//  UIView.swift
//  Barg-InnoFest
//
//  Created by Ryan The on 29/8/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import UIKit

extension UIView {

    // In order to create computed properties for extensions, we need a key to
    // store and access the stored property
    fileprivate struct AssociatedObjectKeys {
        static var gestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }

    fileprivate typealias Action = ((_ sender: UIGestureRecognizer) -> Void)?
    
    // Set our computed property type to a closure
    fileprivate var gestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.gestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let gestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.gestureRecognizer) as? Action
            return gestureRecognizerActionInstance
        }
    }

    // This is the meat of the sauce, here we create the tap gesture recognizer and
    // store the closure the user passed to us in the associated object we declared above
    public func addGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, action: ((_ sender: UIGestureRecognizer) -> Void)?) {
        self.isUserInteractionEnabled = true
        self.gestureRecognizerAction = action
        gestureRecognizer.addTarget(self, action: #selector(handleGesture))
        self.addGestureRecognizer(gestureRecognizer)
    }

    // Every time the user taps on the UIImageView, this function gets called,
    // which triggers the closure we stored
    @objc fileprivate func handleGesture(sender: UIGestureRecognizer) {
        if let action = self.gestureRecognizerAction {
            action?(sender)
        } else {
            print("no action")
        }
    }

}
