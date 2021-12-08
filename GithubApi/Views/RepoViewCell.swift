//
//  RepoViewCell.swift
//  GithubApi
//
//  Created by Слава Платонов on 13.10.2021.
//

import UIKit

class RepoViewCell: UITableViewCell {
    
    private lazy var repoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 16.5)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
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
        
        NSLayoutConstraint.activate([repoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                                     repoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                                     dateLabel.leadingAnchor.constraint(equalTo: repoLabel.leadingAnchor),
                                     dateLabel.topAnchor.constraint(equalTo: repoLabel.bottomAnchor, constant: 10)
                                    ])
        
    }
}

