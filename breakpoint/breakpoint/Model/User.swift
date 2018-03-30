//
//  Profile.swift
//  breakpoint
//
//  Created by Satyia Anand on 14/03/2018.
//  Copyright © 2018 Satyia Anand. All rights reserved.
//

import Foundation

class User {
    
    private var _key: String
    private var _senderId: String

    
    var key: String {
        return _key
    }
    var senderId: String {
        return _senderId
    }

    
    init(key: String, senderId: String){
        
        self._key = key
        self._senderId = senderId
       
    }
}
