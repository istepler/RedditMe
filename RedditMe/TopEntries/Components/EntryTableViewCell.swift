//
//  EntryTableViewCell.swift
//  RedditMe
//
//  Created by Andrey Krit on 12.11.2020.
//

import UIKit

class EntryTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    func configure(model: Entry) {
        titleLabel.text = model.title
        authorLabel.text = model.author
        dateLabel.text = model.createdAt
        commentsLabel.text = model.commentsCount
    }
}
