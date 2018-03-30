//
//  CreateGroupVC.swift
//  breakpoint
//
//  Created by Satyia Anand on 08/03/2018.
//  Copyright © 2018 Satyia Anand. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupVC: UIViewController {

    @IBOutlet weak var titleTextField: InsetTextField!
    
    @IBOutlet weak var descriptionTextField: InsetTextField!
    
    @IBOutlet weak var addEmailTextField: InsetTextField!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneBtn: UIButton!
    
    @IBOutlet weak var addedEMailsLabel: UILabel!
    
    var emailArray = [String]()
    var choosenUserArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        addEmailTextField.delegate = self
        addEmailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        self.hideKeyboardWhenTappedElsewhere()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        doneBtn.isHidden = true
    }
    @objc func textFieldDidChange() {
        if addEmailTextField.text == ""{
            emailArray = []
            tableView.reloadData()
        }else {
            DataService.instance.getEmail(forSearchQuery: addEmailTextField.text!, handler: { (returnedemailArray) in
                self.emailArray = returnedemailArray
                self.tableView.reloadData()
            })
        }
    }

    @IBAction func doneBtnPressed(_ sender: Any) {
        if titleTextField.text != "" && descriptionTextField.text != "" {
            DataService.instance.getIds(forUsername: choosenUserArray, handler: { (idsArray) in
                var userIds = idsArray
                userIds.append((Auth.auth().currentUser?.uid)!)
                
                DataService.instance.createGroup(withTitle: self.titleTextField.text!, andDescription: self.descriptionTextField.text!, forUserIds: userIds, handler: { (groupCreated) in
                    if groupCreated {
                        self.dismiss(animated: true, completion: nil)
                    }else {
                        print("Group cant be created")
                    }
                })
            })
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}


extension CreateGroupVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else {return UITableViewCell()}
        let profile = UIImage(named: "defaultProfileImage")
        
        if choosenUserArray.contains(emailArray[indexPath.row]){
            
        
            cell.configureCell(profileImage: profile!, email: emailArray[indexPath.row], isSelected: true)
        } else {
            cell.configureCell(profileImage: profile!, email: emailArray[indexPath.row], isSelected: false)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        if !choosenUserArray.contains(cell.emailLabel.text!){
            choosenUserArray.append(cell.emailLabel.text!)
            addedEMailsLabel.text = choosenUserArray.joined(separator: ", ")
            doneBtn.isHidden = false
        }else {
            choosenUserArray = choosenUserArray.filter({ $0 != cell.emailLabel.text! })
            if choosenUserArray.count >= 1 {
                addedEMailsLabel.text = choosenUserArray.joined(separator: ", ")
            } else {
                addedEMailsLabel.text = "ADD PEOPLE"
                doneBtn.isHidden = true
            }
        }
    }
    
}

extension CreateGroupVC: UITextFieldDelegate {
    
}
