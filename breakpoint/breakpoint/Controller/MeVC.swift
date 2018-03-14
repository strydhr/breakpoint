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
        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeprofileimage)))
        profileImage.isUserInteractionEnabled = true
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

extension MeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    @objc func changeprofileimage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImagefromPicker: UIImage?
        let imageName = NSUUID().uuidString
        let storage = Storage.storage()
        let storageRef = storage.reference().child("profileImage").child("\(imageName).png")
        
        if let editedImage = info["UIImagePickerControllerEditedImage"]  {
            selectedImagefromPicker = editedImage as? UIImage
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] {
            selectedImagefromPicker = originalImage as? UIImage
        }
        
        
        profileImage.image = selectedImagefromPicker
        
        if let uploaddata = UIImagePNGRepresentation(profileImage.image!){
            
            storageRef.putData(uploaddata, metadata: nil, completion: { (metadata, error) in
                guard let metadata = metadata else { return}
                let downloadURL = metadata.downloadURL()?.absoluteString
                
                DataService.instance.uploadProfileImage(withUID: (Auth.auth().currentUser?.uid)!, imageFile: downloadURL!, withDetail: nil, imageCreated: { (success) in
                    if success {
                        print("it works")
                    }else{
                        print("madamada")
                    }
                })
            })
        }
        
        
        
//        DataService.instance.uploadProfileImage(withUID: (Auth.auth().currentUser?.uid)!, imageFile: profileImage, withDetail: nil) { (success) in
//            if success {
//                print("i works")
//            }else{
//                print("no workie")
//            }
//        }
       
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("image pick canceled")
        dismiss(animated: true, completion: nil)
    }
        
    
    
}
