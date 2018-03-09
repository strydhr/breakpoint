//
//  UserCell.swift
//  breakpoint
//
//  Created by Satyia Anand on 09/03/2018.
//  Copyright © 2018 Satyia Anand. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

   
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    var showing = false
    
    func configureCell(profileImage image: UIImage, email: String, isSelected: Bool){
        self.profileImage.image = image
        self.emailLabel.text = email
        if isSelected {
            self.checkImage.isHidden = false
        }else {
            self.checkImage.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            if showing == false {
                checkImage.isHidden = false
                showing = true
            
            }else {
            checkImage.isHidden = true
            showing = false
            }
        }
    }

}
