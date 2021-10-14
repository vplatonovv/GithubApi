//
//  DetailRepoViewController.swift
//  GithubApi
//
//  Created by Слава Платонов on 13.10.2021.
//

import UIKit

class DetailRepoViewController: UIViewController {
    
    private var repos: [Repos] = []

    @IBOutlet weak var userImage: UIImageView! {
        didSet {
            userImage.layer.cornerRadius = 20
            userImage.layer.borderWidth = 2
            userImage.layer.borderColor = UIColor.systemBlue.cgColor
        }
    }
    
    @IBOutlet weak var repoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        repoTableView.delegate = self
        repoTableView.dataSource = self
        repoTableView.rowHeight = 80
    }
    
    func fetchData(with url: String) {
        NetworkManager.shared.fetchRepo(url: url) { result in
            switch result {
            case .success(let repos):
                self.repos = repos
                self.repoTableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchImage(with url: String) {
        NetworkManager.shared.fetchImage(from: url) { data, _ in
            self.userImage.image = UIImage(data: data)
        }
    }
    
}

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
        "Repos"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
