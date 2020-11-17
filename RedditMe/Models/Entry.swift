//
//  Entry.swift
//  RedditMe
//
//  Created by Andrey Krit on 13.11.2020.
//

import Foundation

struct EntryModel: Codable {
    let data: EntryDataModel
}

struct EntryDataModel: Codable {
    let name: String
    let title: String
}

struct Entry {
    let name: String
    let title: String
    
    init(_ model: EntryModel) {
        name = model.data.name
        title = model.data.title
    }
}
