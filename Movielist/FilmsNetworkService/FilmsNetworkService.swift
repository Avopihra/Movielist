//
//  NetworkService.swift
//  Movielist
//
//  Created by Viktoriya on 02.12.2021.
//

import Foundation

class FilmsNetworkService {
    private init() {}
    
    static func getFilms(completion: @escaping(GetFilmResponse?, Error?) -> ()) {
        guard let url = URL(string: "https://s3-eu-west-1.amazonaws.com/sequeniatesttask/films.json") else {
            return
        }
        NetworkService.shared.getData(url: url) { (json, error) in
            do {
                let response = try GetFilmResponse(json: json)
                completion(response, nil)
            } catch {
                completion(nil, error)
                print(error)
            }
        }
    }
}

