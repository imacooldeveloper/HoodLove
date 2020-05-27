//
//  User.swift
//  HoodLove
//
//  Created by Martin Gallardo on 5/18/20.
//  Copyright © 2020 Martin Gallardo. All rights reserved.
//


import Foundation
struct User {
    let userName: String
    var uid: String
    let userEmail: String
 
 
    init(uid: String,dictornary:[String:Any]) {
        userName = dictornary["username"] as? String ?? ""
        self.uid = uid
     
      
        userEmail = dictornary["userEmail"] as? String ?? ""
   
    }
}
