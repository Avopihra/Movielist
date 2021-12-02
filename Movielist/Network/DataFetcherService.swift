//
//  DataFetcherService.swift
//  Movielist
//
//  Created by Viktoriya on 02.12.2021.
//

import Foundation

struct GetFilmResponse {
    typealias JSON = [String: AnyObject]
    var films = [Film]()
    
    init(json: Any) throws {
        guard let array = json as? JSON else { throw NetworkError.faleInternetError }
        var films = [Film]()
        guard let filmsData = array["films"] as? [AnyObject] else { return }
        for dictionary in filmsData {
            guard let film = Film(dict: dictionary as? [String : AnyObject] ?? [:]) else { continue }
            self.films.append(film)
        }
//        self.films = films as? [Film] ?? [Film]()
    }
}

//class DataFetcherService {
//
//    var networkDataFetcher: DataFetcher
//
//    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
//        self.networkDataFetcher = dataFetcher
//    }
//
//    func fetchFilms(completion: @escaping (FilmModel?) -> Void) {
//        let urlString = "https://s3-eu-west-1.amazonaws.com/sequeniatesttask/films.json"
//        networkDataFetcher.fetchGenericJSONData(urlString: urlString, response: completion)
//    }
//}
