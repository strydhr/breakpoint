//
//  LoginVC.swift
//  breakpoint
//
//  Created by Satyia Anand on 07/03/2018.
//  Copyright © 2018 Satyia Anand. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: InsetTextField!
    
    @IBOutlet weak var passwordTextField: InsetTextField!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextField.delegate = self
        passwordTextField.delegate = self
        self.hideKeyboardWhenTappedElsewhere()
    }

    @IBAction func closeBtnPressed(_ sender: Any) {
        do{
           try Auth.auth().signOut()
        }catch{
            print(error)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        if emailTextField.text != nil && passwordTextField.text != nil {
            
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                if let user = Auth.auth().currentUser{
                    if !user.isEmailVerified{
                        print("namukuhukumaka")
                        let EmailVerificationAlert = UIAlertController(title: "Verification Error", message: "Email haven't been verified", preferredStyle: .alert)
                        EmailVerificationAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(EmailVerificationAlert, animated: true, completion: nil)
                        do{
                            try Auth.auth().signOut()
                        }catch{
                            print(error)
                        }
                    }else{
                        print("sign in")
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                }else {
                    Auth.auth().fetchProviders(forEmail: self.emailTextField.text!, completion: { (stringArray, error) in
                        if error != nil {
                            print(error!)
                        }else{
                            
                            if stringArray == nil {
                                print("No such email registered")
                                let noEmailRegAlert = UIAlertController(title: "Login Error", message: "No such email registered", preferredStyle: .alert)
                                noEmailRegAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.present(noEmailRegAlert, animated: true, completion: nil)
                            } else {
                                print("Password is invalid")
                                let wrongPasswordAlert = UIAlertController(title: "Login Error", message: "Password entered is invalid", preferredStyle: .alert)
                                wrongPasswordAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.present(wrongPasswordAlert, animated: true, completion: nil)
                            }
                        }
                    })
                }
            })
            
//            AuthService.instance.loginUser(withEmail: emailTextField.text!, andPassword: passwordTextField.text!, loginComplete: { (success, loginError) in
//                if success{
//                    self.dismiss(animated: true, completion: nil)
//                } else {
//
//                    Auth.auth().fetchProviders(forEmail: self.emailTextField.text!, completion: { (stringArray, error) in
//                        if error != nil {
//                            print(error!)
//                        }else{
//
//                            if stringArray == nil {
//                                print("No such email registered")
//                                let noEmailRegAlert = UIAlertController(title: "Login Error", message: "No such email registered", preferredStyle: .alert)
//                                noEmailRegAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                                self.present(noEmailRegAlert, animated: true, completion: nil)
//                            } else {
//                                print("Password is invalid")
//                                let wrongPasswordAlert = UIAlertController(title: "Login Error", message: "Password entered is invalid", preferredStyle: .alert)
//                                wrongPasswordAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                                self.present(wrongPasswordAlert, animated: true, completion: nil)
//                            }
//                        }
//                    })
//
//                }
//            })
            //
        }
    }
    
    @IBAction func pwdRecoveryBtnPressed(_ sender: Any) {
        present((storyboard?.instantiateViewController(withIdentifier: "recoveryVC"))!, animated: true, completion: nil)
    }
    
}

extension LoginVC: UITextFieldDelegate{
    
}
