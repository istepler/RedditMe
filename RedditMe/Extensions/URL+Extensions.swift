//
//  URL+Extensions.swift
//  RedditMe
//
//  Created by Andrey Krit on 16.11.2020.
//

import Foundation

extension URL {
    
    var queryParameters: [String: String]? {
        let components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        return components?.queryItems?.reduce(into: [String: String]()) { (result, item) in
                result[item.name] = item.value
        }
    }
    
}
