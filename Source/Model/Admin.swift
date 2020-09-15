//
//  Admin.swift
//  Barg-InnoFest
//
//  Created by Ryan The on 14/9/20.
//  Copyright © 2020 Ryan The. All rights reserved.
//

import Foundation
import FirebaseAuth

class Admin {
    var isAdmin: Bool {
        Auth.auth().currentUser?.email == K.stallOwner.email
    }
    
    var isAdminModeOn = false
}
