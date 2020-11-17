//
//  TopEntriesViewModel.swift
//  RedditMe
//
//  Created by Andrey Krit on 12.11.2020.
//

import Foundation

protocol TopEntriesViewModelProtocol: class {
    var entries: [Entry] { get }
    var enter: (()->())? { get set }
    var didUpdate: (()->())? { get set }
}

class TopEntriesViewModel: TopEntriesViewModelProtocol {

    var entries: [Entry] = [] {
        didSet {
            print(entries)
            didUpdate?()
        }
    }
    
    var enter: (() -> ())?
    var didUpdate: (() -> ())?
    
    private let service: TopEntriesServiceProtocol
    
    init(service: TopEntriesServiceProtocol = TopEntriesService()) {
        self.service = service
        NotificationCenter.default.addObserver(self, selector: #selector(onTokenRecieved), name: .didRecieveToken, object: nil)
    }
    
    @objc private func onTokenRecieved() {
        enter?()
        fetch()
    }
    private func fetch() {
        service.fetch { [weak self] entries in
            self?.entries.append(contentsOf: entries)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
