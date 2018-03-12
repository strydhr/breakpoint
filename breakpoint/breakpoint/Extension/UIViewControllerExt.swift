//
//  UIViewControllerExt.swift
//  breakpoint
//
//  Created by Satyia Anand on 12/03/2018.
//  Copyright © 2018 Satyia Anand. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentDetail(_ viewCOntrollerToPresent: UIViewController){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(viewCOntrollerToPresent, animated: false, completion: nil)
    }
    
    func dismissDetail(){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
}
