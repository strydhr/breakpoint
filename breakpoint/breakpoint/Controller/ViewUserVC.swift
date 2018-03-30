//
//  ViewUserVC.swift
//  breakpoint
//
//  Created by Satyia Anand on 26/03/2018.
//  Copyright © 2018 Satyia Anand. All rights reserved.
//

import UIKit
import Firebase

class ViewUserVC: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var userImage: CircleImage!
    
    var message: Message?
    
    func initUserData(forMessage message: Message){
        self.message = message
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let id = message?.senderId
        DataService.instance.getUsername(forUID: id!) { (username) in
            self.emailLabel.text = username
        }
        DataService.instance.getProfile(forUID: id!) { (profileImage) in
            let imageChecker = profileImage
            if imageChecker != ""{
                let url = NSURL(string: imageChecker)!
                ImageService.getImages(withURL: url as URL, completion: { (image) in
                    self.userImage.image = image
                })
            }
        }
        DataService.instance.getProfileUsername(forUID: id!) { (username) in
            self.usernameLabel.text = username
        }
        DataService.instance.getProfileDescription(forUID: id!) { (description) in
            self.descriptionLabel.text = description
        }
    }


    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
