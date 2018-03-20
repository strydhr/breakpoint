//
//  File.swift
//  breakpoint
//
//  Created by Satyia Anand on 20/03/2018.
//  Copyright © 2018 Satyia Anand. All rights reserved.
//

import Foundation
import UIKit

class ImageService{
    
    static let cache = NSCache<NSString, UIImage>()
    
    static func downloadImages(withURL url: URL, completion: @escaping(_ image: UIImage?)->()){
        let dataTask = URLSession.shared.dataTask(with: url) { data, responseurl, error in
            var downloadedImage: UIImage?
            
            if let data = data {
                downloadedImage = UIImage(data: data)
            }
            if downloadedImage != nil {
                cache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
            }
            DispatchQueue.main.async {
                completion(downloadedImage)
            }
            
        }
        
        dataTask.resume()
    }
    
    static func getImages(withURL url: URL, completion: @escaping(_ image: UIImage?)->()){
        if let image = cache.object(forKey: url.absoluteString as  NSString){
            completion(image)
        }else{
            downloadImages(withURL: url, completion: completion)
        }
    }
}
