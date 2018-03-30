//
//  CreatePostVC.swift
//  breakpoint
//
//  Created by Satyia Anand on 08/03/2018.
//  Copyright © 2018 Satyia Anand. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {

    @IBOutlet weak var userProfileImage: CircleImage!
    
    @IBOutlet weak var emailLable: UILabel!
    
    @IBOutlet weak var textField: UITextView!
    
    @IBOutlet weak var sendBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textField.delegate = self
        sendBtn.bindToKeyboard()
        self.hideKeyboardWhenTappedElsewhere()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.emailLable.text = Auth.auth().currentUser?.email
        DataService.instance.getProfile(forUID: (Auth.auth().currentUser?.uid)!) { (getImage) in
            let imageChecker = getImage
            
            if imageChecker != "" {
                let url = NSURL(string: imageChecker)!
                ImageService.getImages(withURL: url as URL, completion: { (profileImage) in
                    self.userProfileImage.image = profileImage
                })
                
            }else{
                self.userProfileImage.image = UIImage(named:"defaultProfileImage")
                
            }
        }
    }

    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func sendBtnPressed(_ sender: Any) {
        if textField.text !=  nil && textField.text != "Hey there, say something..." {
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: textField.text, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil, sendComplete: { (isComplete) in
                if isComplete{
                    self.sendBtn.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                }else {
                    self.sendBtn.isEnabled = true
                    print("There is an Error")
                }
            })
        }
    }
}

extension CreatePostVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textField.text != nil && textField.text != "Hey there, say something..." {
            textField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }else{
        textField.text = ""
        textField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
}
