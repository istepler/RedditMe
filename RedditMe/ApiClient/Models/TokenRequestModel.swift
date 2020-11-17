//
//  TokenRequestModel.swift
//  RedditMe
//
//  Created by Andrey Krit on 17.11.2020.
//

import Foundation

struct TokenRequestModel {
    var code: String
    var redirectUri: String
    
    var urlEncoded: Data? {
        "grant_type=authorization_code&code=\(code)&redirect_uri=\(redirectUri)".data(using: .utf8)
    }
}
