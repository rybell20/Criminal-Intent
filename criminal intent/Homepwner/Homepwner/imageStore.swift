//
//  imageStore.swift
//  CriminalIntent
//
//  Created by Bell, Ryan J. on 2/22/18.
//  Copyright © 2018 Bell, Ryan J. All rights reserved.
//

import Foundation
import UIKit

class ImageStore {
    let cache = NSCache<NSString,UIImage>()
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
    
}

