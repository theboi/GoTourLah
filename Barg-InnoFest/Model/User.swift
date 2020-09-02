//
//  User.swift
//  Barg-InnoFest
//
//  Created by Ryan The on 2/9/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn

class User {
    @objc static func signIn() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @objc static func signOut() {
        do {
            try Auth.auth().signOut()
            print("Success")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        return
    }
}
