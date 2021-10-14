//
//  UsersViewController.swift
//  GithubApi
//
//  Created by Слава Платонов on 13.10.2021.
//

import UIKit

class UsersViewController: UIViewController {
    
    private var currentLastId: Int? = nil
    private let limiteUsers = 25
    private var users: [User] = []
    private var isLoading = false
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailRepoViewController else { return }
        guard let index = tableView.indexPathForSelectedRow else { return }
        let user = users[index.row]
        detailVC.fetchData(with: user.reposUrl)
        detailVC.fetchImage(with: user.avatarUrl)
        detailVC.title = user.login
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
    }
    
    private func fetchData() {
        NetworkManager.shared.fetchUsers(perPage: limiteUsers, sinceId: currentLastId) { result in
            switch result {
            case .success(let users):
                guard !self.isLoading else { return }
                self.users.append(contentsOf: users)
                self.tableView.reloadData()
                self.currentLastId = users.last?.id
                self.isLoading = true
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(with: "Ошибка подключения", and: "Проверьте подключение к сети интернет")
                }
                print(error.localizedDescription)
            }
        }
    }
    
    private func loadMoreData() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 100)
        spinner.startAnimating()
        fetchData()
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
        isLoading = false
    }
    
    private func showAlert(with title: String, and message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserViewCell
        let user = users[indexPath.row]
        cell.configureCell(with: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastListIndexPath = IndexPath(row: users.count - 1, section: 0)
        guard !users.isEmpty else { return }
        if indexPath.row == lastListIndexPath.row {
            print("fetch data from \(indexPath.row) started!")
            loadMoreData()
        }
    }
}
