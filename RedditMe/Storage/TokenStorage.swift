//
//  TokenStorage.swift
//  RedditMe
//
//  Created by Andrey Krit on 17.11.2020.
//

import Foundation

// TODO: Implement Keychain
class TokenStorage {
    static let shared = TokenStorage()
    var accessToken: String? {
        didSet {
            NotificationCenter.default.post(.init(name: .didRecieveToken))
        }
    }
    private init() {}
}
