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
    
    private var clientId = "o_OfexqtmVEr2Q"
    private var redirectUri = "com.istepler.RedditMe://auth"
    
    private var params: [String : String] {
        return [
            "client_id" : clientId,
            "response_type" : "code",
            "state" : "somerandomstring",
            "duration" : "permanent",
            "scope" : "read",
            "redirect_uri" : redirectUri
        ]
    }
    
    private let apiClient = APICLient()
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveAuth), name: .authNotification, object: nil)
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
    
    @objc private func didRecieveAuth(notification: Notification) {
        guard let authURL = notification.object as? URL, let code = authURL.queryParameters?["code"] else {
            print("Authentification failed")
            return
        }
        getToken(for: clientId, model: TokenRequestModel(code: code, redirectUri: redirectUri))
    }
    
    private func getToken(for client: String, model: TokenRequestModel) {
        apiClient.execute(requestType: .topEntries, response: TokenModel.self) { (response, error) in
            print(response)
        }
    }
}
