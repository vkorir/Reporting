//
//  User.swift
//  Reporting
//
//  Created by Victor Korir on 5/2/17.
//  Copyright © 2017 Victor Korir. All rights reserved.
//
import Firebase

struct User {
    let uid: String
    let email: String
    
    init(authData: FIRUser) {
        uid = authData.uid
        email = authData.email!
    }
}
