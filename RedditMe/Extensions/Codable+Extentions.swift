//
//  Codable+Extentions.swift
//  RedditMe
//
//  Created by Andrey Krit on 17.11.2020.
//

import Foundation

extension Encodable {
    
    func encoded() -> Data? { try? JSONEncoder().encode(self) }
    
    func asDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self), let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return nil }
        return dictionary
    }
}
