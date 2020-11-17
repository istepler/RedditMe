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
    
    private let clientId = "o_OfexqtmVEr2Q"
    private let redirectUri = "com.istepler.RedditMe://auth"
    private let authURLString = "https://www.reddit.com/api/v1/authorize.compact"
    
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
    
    private let apiClient = APIClient()
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveAuth), name: .authNotification, object: nil)
    }
    
    private var authUrl: URL? {
        return authURLString.asURLWithComponents(params: params)
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
        apiClient.execute(requestType: .token(clientId: clientId, body: model), response: TokenModel.self) { (tokenData, error) in
            guard let token = tokenData?.accessToken else {
                print("Authentification failed")
                return
            }
            print(token)
        }
    }
    
}
