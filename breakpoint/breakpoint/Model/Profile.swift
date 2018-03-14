//
//  Profile.swift
//  breakpoint
//
//  Created by Satyia Anand on 14/03/2018.
//  Copyright © 2018 Satyia Anand. All rights reserved.
//

import Foundation

class Profile {
    private var _profileId: String
    private var _imageName: String
    private var _description: String
    
    var profileId: String{
        return _profileId
    }
    var imageName: String{
        return _imageName
    }
    var decription: String{
        return _description
    }
    
    init(profileId: String, imageName: String, desciption: String){
        self._profileId = profileId
        self._imageName = imageName
        self._description = desciption
    }
}
