//
//  ViewController.swift
//  RedditMe
//
//  Created by Andrey Krit on 12.11.2020.
//

import UIKit

class TopEntriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel: TopEntriesViewModelProtocol = TopEntriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension TopEntriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryTableViewCell", for: indexPath) as! EntryTableViewCell
        return cell
    }
    
}

