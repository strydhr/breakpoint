//
//  GroupFeedVC.swift
//  breakpoint
//
//  Created by Satyia Anand on 11/03/2018.
//  Copyright © 2018 Satyia Anand. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupTitleLabel: UILabel!

    @IBOutlet weak var membersLabel: UILabel!
    
    @IBOutlet weak var sendMessageView: UIView!
    
    @IBOutlet weak var messageTextField: InsetTextField!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet var mainView: UIView!
    
    var group: Group?
    var groupMessages = [Message]()
    
    func initData(forGroup group: Group){
        self.group = group
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mainView.bindToKeyboard()
//        sendMessageView.bindToKeyboard()
//        messageTextField.bindToKeyboard()
//        sendBtn.bindToKeyboard()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        
        self.hideKeyboardWhenTappedElsewhere()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTitleLabel.text = group?.groupTitle
        DataService.instance.getEmails(group: group!) { (returnedEmails) in
            self.membersLabel.text = returnedEmails.joined(separator: ", ")
        }
        membersLabel.text = group?.members.joined(separator: ", ")
        
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllMessagesFor(desiredGroup: self.group!, handler: { (returnedGroupMessages) in
                self.groupMessages = returnedGroupMessages
                self.tableView.reloadData()
                
                if self.groupMessages.count > 0  {
                    self.tableView.scrollToRow(at: IndexPath(row: self.groupMessages.count - 1, section: 0), at: .none, animated: true)
                    self.tableView.estimatedRowHeight = 0
                    self.tableView.estimatedSectionHeaderHeight = 0
                    self.tableView.estimatedSectionHeaderHeight = 0
                }
            })
        }
    }

  
    @IBAction func sendBtnPressed(_ sender: Any) {
        if messageTextField.text != "" {
            messageTextField.isEnabled = false
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMessage: messageTextField.text!, forUID: Auth.auth().currentUser!.uid, withGroupKey: group?.key, sendComplete: { (complete) in
                if complete {
                    self.messageTextField.text = ""
                    self.messageTextField.isEnabled = true
                    self.sendBtn.isEnabled = true
                }
            })
        }
    }
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
}

extension GroupFeedVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell", for: indexPath) as? GroupFeedCell else {return UITableViewCell() }
        let message = groupMessages[indexPath.row]
        DataService.instance.getUsername(forUID: message.senderId) { (email) in
            //
            DataService.instance.getProfile(forUID: message.senderId, handler: { (imageProfile) in
                let imageChecker = imageProfile
                if imageChecker != "" {
                    let url = NSURL(string: imageChecker)
                    ImageService.getImages(withURL: url! as URL, completion: { (userImage) in
                        cell.configureCell(profileImage: userImage!, email: email, content: message.content)
                    })
                }else{
                    
                    cell.configureCell(profileImage: UIImage(named: "defaultProfileImage")!, email: email, content: message.content)
                }
            })
            //cell.configureCell(profileImage: UIImage(named: "defaultProfileImage")!, email: email, content: message.content)
        }
        
        
        
        return cell
    }
}
