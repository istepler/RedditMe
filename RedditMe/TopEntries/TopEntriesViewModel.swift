//
//  TopEntriesViewModel.swift
//  RedditMe
//
//  Created by Andrey Krit on 12.11.2020.
//

import Foundation

protocol TopEntriesViewModelProtocol {}

class TopEntriesViewModel: TopEntriesViewModelProtocol {
    
    private let authorizationService: AuthorizationServiceProtocol
    init(authorizationService: AuthorizationServiceProtocol = AuthorizationService()) {
        self.authorizationService = authorizationService
    }
}
