//
//  Date+Extensions.swift
//  RedditMe
//
//  Created by Andrey Krit on 18.11.2020.
//

import Foundation

extension Date {
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}
