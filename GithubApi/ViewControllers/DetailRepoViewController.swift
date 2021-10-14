//
//  DetailRepoViewController.swift
//  GithubApi
//
//  Created by Слава Платонов on 13.10.2021.
//

import UIKit

class DetailRepoViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView! {
        didSet {
            userImage.layer.cornerRadius = 20
            userImage.layer.borderWidth = 2
            userImage.layer.borderColor = UIColor.systemBlue.cgColor
        }
    }
    
    @IBOutlet weak var repoTableView: UITableView!
    
    private var repos: [Repos] = []
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchImage(with: user.avatarUrl)
        fetchData(with: user.reposUrl)
    }
    
    func fetchImage(with url: String) {
        guard let url = URL(string: url) else { return }
        userImage.fetchImage(from: url)
    }
    
    func fetchData(with url: String) {
        NetworkManager.shared.fetchRepo(from: url) { result in
            switch result {
            case .success(let repos):
                self.repos = repos
                self.repoTableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureTableView() {
        repoTableView.delegate = self
        repoTableView.dataSource = self
        repoTableView.rowHeight = 80
    }
}

//MARK: TableViewDataSource, TableViewDelegate

extension DetailRepoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = repoTableView.dequeueReusableCell(withIdentifier: "repo", for: indexPath) as! RepoViewCell
        let repo = repos[indexPath.row]
        cell.configureCell(with: repo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Repositories"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
