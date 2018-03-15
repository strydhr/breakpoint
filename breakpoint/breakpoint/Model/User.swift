//
//  Profile.swift
//  breakpoint
//
//  Created by Satyia Anand on 14/03/2018.
//  Copyright © 2018 Satyia Anand. All rights reserved.
//

import Foundation

class User {
    //private var _uid: String
    private var _email: String
    private var _profileImage: String
    
//    var uid:String{
//        return _uid
//    }
    
    var email: String {
        return _email
    }
    var profileImage: String {
        return _profileImage
    }
    
//    init(dictionary: [String: Any]){
//        self.email = dictionary["email"] as? String
//        self.profileImage = dictionary["profileImage"] as? String
//    }
    
    //private var _description: String
    

//    var decription: String{
//        return _description
//    }
    
    init(email: String, profileImage: String){
        //self._uid = uid
        self._email = email
        self._profileImage = profileImage
       // self._description = desciption
    }
}
