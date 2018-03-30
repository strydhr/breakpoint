//
//  AuthVC.swift
//  breakpoint
//
//  Created by Satyia Anand on 07/03/2018.
//  Copyright © 2018 Satyia Anand. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class AuthVC: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func logininByEmalBtnPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }
    

  
    
    @IBAction func logininWithFbBtnPressed(_ sender: Any) {
       print("123131")
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, error) in
            if error != nil {
                print("nondi")
                print(error!)
                return
            }
            print("nondo")
            FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start(completionHandler: { (connection, result, error) in
                if error != nil {
                    print(error!)
                    return
                }
               
                self.loginWithFB()
            })
            
        }
        
    }
    
    func loginWithFB(){
        
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else { return }
        let credential = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("error")
            }else{
               
                let userData = ["provider": user?.providerID, "email": user?.email]
                DataService.instance.createDBUser(uid: (user?.uid)!, userData: userData)
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
}
