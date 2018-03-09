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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        groupTableView.delegate = self
        groupTableView.dataSource = self
        
    }

   
    

}

extension GroupVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = groupTableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupCell else { return UITableViewCell()}
        //guard let cell = groupTableView.dequeueReusableCell(withIdentifier: "groupCell") as? GroupCell else {return UITableViewCell()}
        cell.configureCell(title: "SUperFriends", description: "doing super stuff", memberCount: 3)
        
        return cell
    }
   
}
