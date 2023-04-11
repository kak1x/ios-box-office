//
//  URLCacheManager.swift
//  BoxOffice
//
//  Created by kaki, harry on 2023/04/11.
//

import Foundation

class URLCacheManager {
    private static let inMemoryCache = URLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 0)
    private static let onDiskCache = URLCache(memoryCapacity: 0, diskCapacity: 20 * 1024 * 1024)
    
    static func getURLCache<T: Decodable>(type: T.Type) -> URLCache {
        if type == BoxOffice.self {
            return onDiskCache
        } else {
            return inMemoryCache
        }
    }
}
