//
//  SignUpVC.swift
//  breakpoint
//
//  Created by Satyia Anand on 22/03/2018.
//  Copyright © 2018 Satyia Anand. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {

    @IBOutlet weak var emailTextField: InsetTextField!
    @IBOutlet weak var passwordTextField: InsetTextField!
    
    var email: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedElsewhere()
    }

    @IBAction func signUpBtnPressed(_ sender: Any) {
        if emailTextField.text != nil && passwordTextField.text != nil {
            AuthService.instance.registerUser(withEmail: emailTextField.text!, andPassword: passwordTextField.text!, userCreateComplete: { (success, error) in
                if success {
                    
                    Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                        if error != nil{
                            print("error")
                        }
                        let verifyEmailAlert = UIAlertController(title: "Email Verification" , message: "An email have been sent to your email to verify your account", preferredStyle: .alert)
                        verifyEmailAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(verifyEmailAlert, animated: true, completion: nil)
                    })
                    
//                    AuthService.instance.loginUser(withEmail: self.emailTextField.text!, andPassword: self.passwordTextField.text!, loginComplete: { (success, nil) in
//                        print("user Registered")
//                        let meVC =  self.storyboard?.instantiateViewController(withIdentifier: "MeVc")
//                        self.presentDetail(meVC!)
//                    })
                }else{
                    if (self.passwordTextField.text?.count)! > 5 {
                        //code if password is fine
                        
                        let alert = UIAlertController(title: "Error in Registration", message: "Email Have Already Been registered", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        print("user exist")
                        
                    }else {
                        //code if password to short
                        let passwordAlert = UIAlertController(title: "Password Error", message: "Password need to be at least 6 characters long", preferredStyle: .alert)
                        passwordAlert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                        self.present(passwordAlert, animated: true, completion: nil)

                    }
                  
                }
            })
        }
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
