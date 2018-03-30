//
//  SecondViewController.swift
//  breakpoint
//
//  Created by Satyia Anand on 07/03/2018.
//  Copyright © 2018 Satyia Anand. All rights reserved.
//

import UIKit

class GroupVC: UIViewController {

    @IBOutlet weak var groupTableView: UITableView!
    var groupsArray = [Group]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        groupTableView.delegate = self
        groupTableView.dataSource = self
        //self.hideKeyboardWhenTappedElsewhere()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllGroup { (returnedGroupsArray) in
                self.groupsArray = returnedGroupsArray 
                self.groupTableView.reloadData()
            }
        }
        
    }

   
    

}

extension GroupVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = groupTableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupCell else { return UITableViewCell()}
        //guard let cell = groupTableView.dequeueReusableCell(withIdentifier: "groupCell") as? GroupCell else {return UITableViewCell()}
        let group = groupsArray[indexPath.row]
        
        cell.configureCell(title: group.groupTitle, description: group.groupDesc, memberCount: group.memberCount)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC =  storyboard?.instantiateViewController(withIdentifier: "groupFeedVC") as? GroupFeedVC else { return }
        groupFeedVC.initData(forGroup: groupsArray[indexPath.row])
        presentDetail(groupFeedVC)
    }
   
}
