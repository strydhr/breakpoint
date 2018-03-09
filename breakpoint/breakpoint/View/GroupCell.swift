//
//  GroupCell.swift
//  breakpoint
//
//  Created by Satyia Anand on 09/03/2018.
//  Copyright © 2018 Satyia Anand. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var groupTitleLabel: UILabel!
    
    @IBOutlet weak var groupDescLabel: UILabel!
    
    @IBOutlet weak var memberCountLabel: UILabel!
    
    func configureCell(title: String, description: String, memberCount: Int){
        self.groupTitleLabel.text = title
        self.groupDescLabel.text = description
        self.memberCountLabel.text = "\(memberCount)members."
    }
}
