//
//  CommentNetworkService.swift
//  Movielist
//
//  Created by Viktoriya on 02.12.2021.
//

import Foundation

class NetworkService {
    private init() {}
    
    static let shared = NetworkService()
    
    public func getData(url: URL, completion: @escaping (Any?, NetworkError?) -> ()) {
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, NetworkError.networkError)
                }
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                DispatchQueue.main.async {
                    completion(json, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, NetworkError.networkError)
                }
            }
        }.resume()
    }
}
