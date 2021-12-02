//
//  UserViewCell.swift
//  GithubApi
//
//  Created by Слава Платонов on 13.10.2021.
//

import UIKit

class UserViewCell: UITableViewCell {
    
    private lazy var avatarImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 16.5)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(avatarImageView)
        addSubview(loginLabel)
        setupConstrains()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func configureCell(with user: User) {
        loginLabel.text = user.login
        guard let url = URL(string: user.avatarUrl) else { return }
        avatarImageView.fetchImage(from: url)
    }

    private func setupConstrains() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                                     avatarImageView.heightAnchor.constraint(equalToConstant: 60),
                                     avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor)
                                    ])
        NSLayoutConstraint.activate([loginLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
                                     loginLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
                                     loginLabel.heightAnchor.constraint(equalToConstant: 50)
                                    ])
    }
}
