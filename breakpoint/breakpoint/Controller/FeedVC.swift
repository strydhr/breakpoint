//
//  FirstViewController.swift
//  breakpoint
//
//  Created by Satyia Anand on 07/03/2018.
//  Copyright © 2018 Satyia Anand. All rights reserved.
//

import UIKit
import Firebase

class FeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var messageArray = [Message]()
    //
    var userArray = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.getAllFeedMessages { (returnedMessageArray) in
            self.messageArray = returnedMessageArray.reversed()
            self.tableView.reloadData()
        }
    }


}

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as? FeedCell else
        { return UITableViewCell() }
        //let image = UIImage(named: "defaultProfileImage")
        let message = messageArray[indexPath.row]
        //

        DataService.instance.getUsername(forUID: message.senderId) { (returnedUsername) in
            DataService.instance.getProfile(forUID: message.senderId, handler: { (getProfile) in
                //let url = NSURL(string: getProfile)!
                //let data = NSData(contentsOf: url as URL)!
                //let image = UIImage(data: data as Data)
                let image = UIImage(named: "defaultProfileImage")
                
                cell.configureCell(profileImage: image!, email: returnedUsername, content: message.content)
            })
           // cell.configureCell(profileImage: image!, email: returnedUsername, content: message.content)
        }
//
       
        
        return cell
    }
}
