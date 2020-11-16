//
//  TopEntriesViewModel.swift
//  RedditMe
//
//  Created by Andrey Krit on 12.11.2020.
//

import Foundation

protocol TopEntriesViewModelProtocol {}

class TopEntriesViewModel: TopEntriesViewModelProtocol {
    
    init(authorizationService: AuthorizationServiceProtocol = AuthorizationService()) {
        authorizationService.start()
    }
}
