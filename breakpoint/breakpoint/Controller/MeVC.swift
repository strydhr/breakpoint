//
//  MeVC.swift
//  breakpoint
//
//  Created by Satyia Anand on 08/03/2018.
//  Copyright © 2018 Satyia Anand. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit



class MeVC: UIViewController {
    

    @IBOutlet weak var profileImage: CircleImage!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    //
   
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var editBtn: UIButton!
    
    @IBOutlet weak var editDescBtn: UIButton!
    @IBOutlet weak var descriptionTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeprofileimage)))
        profileImage.isUserInteractionEnabled = true
        
        usernameTextField.delegate = self
        editBtn.isHidden = true
        descriptionTextField.delegate = self
        editDescBtn.isHidden = true
        self.hideKeyboardWhenTappedElsewhere()
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.emailLabel.text = Auth.auth().currentUser?.email
        //
        usernameTextField.addTarget(self, action: #selector(editfield), for: .editingChanged)
        
     
       
        DataService.instance.getProfile(forUID: (Auth.auth().currentUser?.uid)!) { (getImage) in
            let imageChecker = getImage
            
            if imageChecker != "" {
                let url = NSURL(string: imageChecker)!
                ImageService.getImages(withURL: url as URL, completion: { (profileImage) in
                    self.profileImage.image = profileImage
                    
                })
                
            }else{
                self.profileImage.image = UIImage(named:"defaultProfileImage")
             
            }
        }
        DataService.instance.getProfileUsername(forUID: (Auth.auth().currentUser?.uid)!) { (username) in
            self.usernameTextField.text = username
        }
        DataService.instance.getProfileDescription(forUID: (Auth.auth().currentUser?.uid)!) { (description) in
            self.descriptionTextField.text = description
        }
        
    }
    
    @objc func editfield(){
        if usernameTextField.text == ""{
            editBtn.isHidden = true
        }else {
            editBtn.isHidden = false
            
        }
    }
    
    
    @IBAction func editBtnPressed(_ sender: Any) {
        if usernameTextField.text != "" {
            DataService.instance.addProfileUsername(withUID: (Auth.auth().currentUser?.uid)!, username: usernameTextField.text!)
            editBtn.isHidden = true
        }
    
    }
    
    @IBAction func editDescBtnPressed(_ sender: Any) {
        if descriptionTextField.text != "" {
            DataService.instance.addProfileDescription(withUID: (Auth.auth().currentUser?.uid)!, description: descriptionTextField.text!)
            editDescBtn.isHidden = true
        }
    }
    
    
    

    @IBAction func logOutBtnPressed(_ sender: Any) {
        
        let logOutPopUP = UIAlertController(title: "Logout?", message: "Are you sure you want to log out?", preferredStyle: .alert)
        logOutPopUP.addAction(UIAlertAction(title: "Logout", style: .default, handler: { (buttonTapped) in
            do{
                try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
                self.present(authVC!, animated: true, completion: nil)
                FBSDKAccessToken.setCurrent(nil)
                FBSDKLoginManager().logOut()
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

extension MeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    @objc func changeprofileimage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImagefromPicker: UIImage?
        //let imageName = NSUUID().uuidString
        let imageName = Auth.auth().currentUser?.uid as! String
        let storage = Storage.storage()
        //let storageRef = storage.reference().child("profileImage").child("\(imageName).png")
        let storageRef = storage.reference().child("profileImage").child("\(imageName)")
        
     
        if let editedImage = info["UIImagePickerControllerEditedImage"]  {
            selectedImagefromPicker = editedImage as? UIImage
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] {
            selectedImagefromPicker = originalImage as? UIImage
        }

        if let uploaddata = UIImageJPEGRepresentation(selectedImagefromPicker!, 0.6){
        
                    let metaData = StorageMetadata()
                    metaData.contentType = "image/jpg"
            
            storageRef.putData(uploaddata, metadata: metaData, completion: { (metadata, error) in
                guard let metadata = metadata else { return}
                let downloadURL = metadata.downloadURL()?.absoluteString
                
                DataService.instance.uploadProfileImage(withUID: (Auth.auth().currentUser?.uid)!, imageFile: downloadURL!, withDetail: nil, imageCreated: { (success) in
                    if success {
                        print("it works")
                        DataService.instance.getProfile(forUID: (Auth.auth().currentUser?.uid)!, handler: { (getImage) in
                            let url = NSURL(string: getImage)!
                            ImageService.getImages(withURL: url as URL, completion: { (profileImage) in
                                self.profileImage.image = profileImage
                                
                            })
                        })
                    }else{
                        print("madamada")
                    }
                })
            })
        }
       
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("image pick canceled")
        dismiss(animated: true, completion: nil)
    }
        
    
    
}

extension MeVC: UITextFieldDelegate{
    
}
extension MeVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        descriptionTextField.text = ""
        descriptionTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        editDescBtn.isHidden = false

    }
    func textViewDidChange(_ textView: UITextView) {
        if descriptionTextField.text == ""{
        
            editDescBtn.isHidden = true
        }else{
            editDescBtn.isHidden = false
        }
       
    }
   
}
