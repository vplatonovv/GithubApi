//
//  RepoViewCell.swift
//  GithubApi
//
//  Created by Слава Платонов on 13.10.2021.
//

import UIKit

class RepoViewCell: UITableViewCell {
    
    private let repoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 16.5)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 16.5)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(repoLabel)
        addSubview(dateLabel)
        setupConstrains()
    }
    
    func configureCell(with repo: Repos) {
        repoLabel.text = repo.name
        dateLabel.text = Repos.convertDate(from: repo.createdAt)
    }

    private func setupConstrains() {
        repoLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        repoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        repoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        
        dateLabel.leadingAnchor.constraint(equalTo: repoLabel.leadingAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: repoLabel.bottomAnchor, constant: 10).isActive = true
    }

}

