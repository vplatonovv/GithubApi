//
//  UserViewCell.swift
//  GithubApi
//
//  Created by Слава Платонов on 13.10.2021.
//

import UIKit

class UserViewCell: UITableViewCell {
    
    let avatarImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    let loginLabel: UILabel = {
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
        NetworkManager.shared.fetchImage(from: user.avatarUrl) { data, _ in
            self.avatarImageView.image = UIImage(data: data)
        }
    }

    private func setupConstrains() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        
        avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor).isActive = true
        
        loginLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10).isActive = true
        loginLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20).isActive = true
        loginLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

}
