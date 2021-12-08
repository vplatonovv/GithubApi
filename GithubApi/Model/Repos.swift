//
//  Repos.swift
//  GithubApi
//
//  Created by Слава Платонов on 13.10.2021.
//

import Foundation

struct Repos: Decodable {
    let name: String
    let createdAt: String
    
    static func convertDate(from date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: date) ?? Date.now
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd MMM yyyy"
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
}


