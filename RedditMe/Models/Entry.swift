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
    let author: String?
    let thumbnailUrl: String?
    let createdAt: Date?
    let commentsCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case name, title, author
        case thumbnailUrl = "thumbnail"
        case createdAt = "created_utc"
        case commentsCount = "num_comments"
    }
}

struct Entry {
    let name: String
    let title: String
    let author: String?
    let thumbnailUrl: String?
    let createdAt: String?
    let commentsCount: String?
    
    init(_ model: EntryModel) {
        name = model.data.name
        title = model.data.title
        author = model.data.author
        thumbnailUrl = model.data.thumbnailUrl
        createdAt = model.data.createdAt?.toString
        commentsCount = String(model.data.commentsCount ?? 0) + "comments"
    }
}
