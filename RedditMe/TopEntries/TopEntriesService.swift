//
//  TopEntriesService.swift
//  RedditMe
//
//  Created by Andrey Krit on 18.11.2020.
//

import Foundation

protocol TopEntriesServiceProtocol: class {
    func fetch(after model: EntriesRequestModel, completion: @escaping ([Entry]) -> ())
}

class TopEntriesService: TopEntriesServiceProtocol {
    
    private let apiClient = APIClient()
    
    func fetch(after model: EntriesRequestModel,  completion: @escaping ([Entry]) -> ()) {
        apiClient.execute(requestType: .topEntries,
                          params: model,
                          response: TopEntriesResponseModel.self) { (response, error) in
            guard let response = response else { return }
            let entries: [Entry] = response.data.children.map { model in
                return Entry(model)
            }
            completion(entries)
        }
    }
    
}
