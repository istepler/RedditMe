//
//  UIImageView+Extensions.swift
//  RedditMe
//
//  Created by Andrey Krit on 18.11.2020.
//

import UIKit

extension UIImageView {
    
    //TODO: Implement cache
    func setImage(from url: URL?) {
        guard let url = url else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, _,  error) -> Void in
            if error == nil {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.image = image
                }
            }
        }
        task.resume()
    }
    
}
