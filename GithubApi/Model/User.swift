//
//  User.swift
//  GithubApi
//
//  Created by Слава Платонов on 13.10.2021.
//

import Foundation

struct User: Decodable {
    let login: String
    let id: Int
    let avatarUrl: String
    let reposUrl: String
}
