//
//  MeVC.swift
//  breakpoint
//
//  Created by Satyia Anand on 08/03/2018.
//  Copyright © 2018 Satyia Anand. All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.emailLabel.text = Auth.auth().currentUser?.email
        
 
    }

    @IBAction func logOutBtnPressed(_ sender: Any) {
        
        let logOutPopUP = UIAlertController(title: "Logout?", message: "Are you sure you want to log out?", preferredStyle: .alert)
        logOutPopUP.addAction(UIAlertAction(title: "Logout?", style: .default, handler: { (buttonTapped) in
            do{
                try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
                self.present(authVC!, animated: true, completion: nil)
            } catch{
                print(error)
                
            }
            
        }))
        
        present(logOutPopUP, animated: true, completion:  {
         
            logOutPopUP.view.superview?.isUserInteractionEnabled = true
            logOutPopUP.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backgroundTapped)))
        })
    }

    @objc func backgroundTapped(){
        self.dismiss(animated: true, completion: nil)
    }

}
