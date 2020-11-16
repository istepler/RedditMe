//
//  AuthorizationService.swift
//  RedditMe
//
//  Created by Andrey Krit on 16.11.2020.
//

import Foundation
import UIKit

protocol AuthorizationServiceProtocol {
    func start() 
}

class AuthorizationService: AuthorizationServiceProtocol {
    
    private var params: [String : String] {
        return [
            "client_id" : "o_OfexqtmVEr2Q",
            "response_type" : "code",
            "state" : "somerandomstring",
            "duration" : "permanent",
            "scope" : "read",
            "redirect_uri" : "com.istepler.RedditMe://auth"
        ]
    }
    
    private var authUrl: URL? {
        var queryItems: [URLQueryItem] = []
        for (key, value) in params {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        var components = URLComponents(string: "https://www.reddit.com/api/v1/authorize.compact")
        components?.queryItems = queryItems
        return components?.url
    }
    
    func start() {
        guard let url = authUrl else { return }
        UIApplication.shared.open(url)
    }
}
