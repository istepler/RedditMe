//
//  String+Extensions.swift
//  RedditMe
//
//  Created by Andrey Krit on 17.11.2020.
//

import Foundation

extension String {
    
    func asURLWithComponents(params:[String : Any]?) -> URL? {
        var components = URLComponents(string: self)
        guard let params = params else { return components?.url }
        var queryItems: [URLQueryItem] = []
        for (key, value) in params {
            queryItems.append(URLQueryItem(name: key, value: "\(value)"))
        }
        components?.queryItems = queryItems
        return components?.url
    }
    
    var isURL: Bool {
        return hasPrefix("http://") || hasPrefix("https://")
    }
}
