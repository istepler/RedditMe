//
//  Token.swift
//  RedditMe
//
//  Created by Andrey Krit on 17.11.2020.
//

import Foundation

struct TokenModel: Codable {
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}
