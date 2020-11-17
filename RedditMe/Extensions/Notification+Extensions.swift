//
//  Notification+Extensions.swift
//  RedditMe
//
//  Created by Andrey Krit on 16.11.2020.
//

import Foundation

extension Notification.Name {
    static let authNotification = Self.init("authNotification")
    static let didRecieveToken = Self.init("didRecieveToken")
}
