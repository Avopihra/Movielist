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

//protocol Networking {
//    func request(urlStr: String,
//                 completion: @escaping (Data?, Error?) -> Void)
//}
//
//class NetworkService: Networking {
//    
//    //построение запроса данных по url
//    func request(urlStr: String,
//                 completion: @escaping (Data?, Error?) -> Void) {
//        guard let url = URL(string: urlStr) else { return }
//        let request = URLRequest(url: url)
//        let task = createDataTask(from: request, completion: completion)
//        task.resume()
//}
//    func createDataTask(from request: URLRequest,
//                        completion: @escaping (Data?, Error?)-> Void) -> URLSessionDataTask {
//        return URLSession.shared.dataTask(with: request) { (data, response, error) in
//            DispatchQueue.main.async {
//                completion(data, error)
//            }
//        }
//    }
//}
