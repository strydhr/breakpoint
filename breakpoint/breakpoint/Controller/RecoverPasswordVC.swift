//
//  RecoverPasswordVC.swift
//  breakpoint
//
//  Created by Satyia Anand on 23/03/2018.
//  Copyright © 2018 Satyia Anand. All rights reserved.
//

import UIKit
import Firebase

class RecoverPasswordVC: UIViewController {

    @IBOutlet weak var emailTextField: InsetTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

 
    @IBAction func doneBtnPressed(_ sender: Any) {
        let email = emailTextField.text
        
        
        if email != nil {
            
            Auth.auth().sendPasswordReset(withEmail: email!, completion: { (error) in
                if error != nil {
                    print(error!)
                }else{
                    print("something")
                    let recoveryAlert = UIAlertController(title: "Password Recovery", message: "An email have been sent to your email to reset the password", preferredStyle: .alert)
                    recoveryAlert.addAction(UIAlertAction(title:"Okay", style: .default, handler: { (back) in
                        self.dismiss(animated: true, completion: nil)
//                        let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
//                        self.present(authVC!, animated: true, completion: nil)
                    }))
                    self.present(recoveryAlert, animated: true, completion: {
                        
                    })
                }
            })
        }
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func backgroundtapped(){
        dismiss(animated: true, completion: nil)
    }
    
}
