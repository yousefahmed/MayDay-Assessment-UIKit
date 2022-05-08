//
//  UsersViewController.swift
//  MayDay-Assesment-UIKit
//
//  Created by Yousef Abourady on 2022-05-05.
//

import UIKit
import Combine

class UsersViewController: UIViewController {
    
    private let viewModel = UsersViewModel()
    
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadView), for: .valueChanged)
        refreshControl.tintColor = .systemGray
        tableView.refreshControl = refreshControl
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureLayoutConstraints()
        configureBindings()
        viewModel.loadUsers()
    }

    private func configureBindings() {
        viewModel.$users
            .receive(on: DispatchQueue.main)
            .sink { [weak self] users in
                self?.tableView.reloadData()
            }.store(in: &subscriptions)
        
        viewModel.$viewState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                switch status {
                case .default:
                    self?.tableView.refreshControl?.endRefreshing()
                case .loading:
                    self?.tableView.refreshControl?.beginRefreshing()
                case .error(let error):
                    self?.tableView.refreshControl?.endRefreshing()
                    self?.showError(title: "Error", des: error.localizedDescription)
                }
            }.store(in: &subscriptions)
    }
    
    private func configureSubviews() {
        self.navigationItem.title = "Users"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }
    
    private func configureLayoutConstraints() {
        configureTableViewLayoutConstraints()
    }
    
    private func configureTableViewLayoutConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc private func reloadView() {
        self.viewModel.loadUsers()
    }
}


extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier) as! UserTableViewCell
        cell.configureView(viewModel.users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
}

