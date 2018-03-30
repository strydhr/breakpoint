//
//  AuthService.swift
//  breakpoint
//
//  Created by Satyia Anand on 07/03/2018.
//  Copyright © 2018 Satyia Anand. All rights reserved.
//

import Foundation
import Firebase

class AuthService{
    static let instance = AuthService()
    
    func loginWithFB(){
        
        
    }
    
    func registerUser(withEmail email: String, andPassword password: String, userCreateComplete: @escaping (_ status: Bool, _ error: Error?) -> ()){
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                userCreateComplete(false, error)
                return
            }
            
            let userData = ["provider": user.providerID, "email": user.email]
            DataService.instance.createDBUser(uid: user.uid, userData: userData)
            userCreateComplete(true, nil)
        }
    }
    
    func loginUser(withEmail email: String, andPassword password: String, loginComplete: @escaping (_ status: Bool, _ error: Error?) -> ()){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            //
            if let user = Auth.auth().currentUser {
                if user.isEmailVerified {
                    loginComplete(true,nil)
                }else{
//                    let alert = UIAlertController(title: "asdad", message: "asdada", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                    
                    loginComplete(false,nil)
                    return
                }
            }
            
//            if error != nil{
//                loginComplete(false, error)
//                return
//            }
//            
//            loginComplete(true, nil)
        }
    }
  
}


