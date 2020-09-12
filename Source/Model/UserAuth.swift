//
//  UserAuth.swift
//  Barg-InnoFest
//
//  Created by Ryan The on 2/9/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn

class UserAuth {
    static func signIn() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    static func signOut() {
        do {
            try Auth.auth().signOut()
            print("Success")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        return
    }
}
