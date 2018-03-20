//
//  Cache.swift
//  breakpoint
//
//  Created by Satyia Anand on 15/03/2018.
//  Copyright © 2018 Satyia Anand. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadingFromCache(_ urlString: String){
        
    
        
        let url = NSURL(string: urlString)!
        let data = NSData(contentsOf: url as URL)!
        let image = UIImage(data: data as Data)
        
        imageCache.setObject(image!, forKey: urlString as AnyObject)
        
        
      
    }
}
