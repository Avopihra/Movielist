//
//  NetworkService.swift
//  Movielist
//
//  Created by Viktoriya on 02.12.2021.
//

import Foundation

class FilmNetworkService {
    private init() {}
    
    static func getFilms(completion: @escaping(GetFilmResponse) -> ()) {
        guard let url = URL(string: "https://s3-eu-west-1.amazonaws.com/sequeniatesttask/films.json") else {
            return
        }
        NetworkService.shared.getData(url: url) { (json) in
            do {
                let response = try GetFilmResponse(json: json)
                completion(response)
            } catch {
                print(error)
            }
        }
    }
}

