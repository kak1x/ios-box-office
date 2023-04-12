//
//  ImageCacheManager.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/04/12.
//

import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() { }
}
