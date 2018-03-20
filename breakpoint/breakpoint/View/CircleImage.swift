//
//  CircleImage.swift
//  breakpoint
//
//  Created by Satyia Anand on 15/03/2018.
//  Copyright © 2018 Satyia Anand. All rights reserved.
//

import UIKit

class CircleImage: UIImageView {

    override func awakeFromNib() {
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}
