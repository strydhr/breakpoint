//
//  FeedCell.swift
//  breakpoint
//
//  Created by Satyia Anand on 08/03/2018.
//  Copyright © 2018 Satyia Anand. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {


    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    func configureCell(profileImage: UIImage, email: String, content: String){
        self.profileImage.image = profileImage
        self.emailLabel.text = email
        self.contentLabel.text = content
    }
}
