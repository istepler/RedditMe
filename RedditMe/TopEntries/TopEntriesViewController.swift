//
//  ViewController.swift
//  RedditMe
//
//  Created by Andrey Krit on 12.11.2020.
//

import UIKit

class TopEntriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: TopEntriesViewModelProtocol = TopEntriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        StartViewController.present(in: self)
    }
    
    private func setupViewModel() {
        viewModel.enter = { [weak self] in
            self?.dismiss(animated: true)
        }
        viewModel.didUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension TopEntriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EntryTableViewCell.self), for: indexPath) as! EntryTableViewCell
        cell.configure(model: viewModel.entries[indexPath.row])
        if indexPath.row == viewModel.entries.count - 1 {
            viewModel.fetch()
        }
        return cell
    }
    
}

