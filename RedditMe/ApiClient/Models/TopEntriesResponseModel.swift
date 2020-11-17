//
//  TopEntriesResponseModel.swift
//  RedditMe
//
//  Created by Andrey Krit on 18.11.2020.
//

import Foundation

struct TopEntriesResponseModel: Codable {
    let data: ResponseData
}

struct ResponseData: Codable {
    let children: [EntryModel]
}


