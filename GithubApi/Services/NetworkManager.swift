//
//  NetworkManager.swift
//  GithubApi
//
//  Created by Слава Платонов on 13.10.2021.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    private let gitUrl = "https://api.github.com/users"
    
    func fetchUsers(perPage: Int = 25, sinceId: Int? = nil, completion: @escaping (Result<[User], NetworkError>) -> Void) {
        var components = URLComponents(string: gitUrl)
        components?.queryItems = [
        URLQueryItem(name: "per_page", value: "\(perPage)"),
        URLQueryItem(name: "since", value: sinceId != nil ? "\(sinceId ?? 0)" : "")
        ]
        
        guard let url = components?.url else {
            completion(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let decode = JSONDecoder()
                decode.keyDecodingStrategy = .convertFromSnakeCase
                let users = try decode.decode([User].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(users))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchRepo(url: String, completion: @escaping (Result<[Repos], NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let decode = JSONDecoder()
                decode.keyDecodingStrategy = .convertFromSnakeCase
                let repos = try decode.decode([Repos].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(repos))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImage(from url: String, completion: @escaping(Data, URLResponse) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            DispatchQueue.main.async {
                completion(data, response)
            }
        }.resume()
    }
}
