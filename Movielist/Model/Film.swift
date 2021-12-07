//
//  Film.swift
//  Movielist
//
//  Created by Viktoriya on 01.12.2021.
//

import Foundation

struct FilmModel: Decodable {
    var films: [Film]
}

struct Film: Decodable {
    
    var id: Int?
    var localized_name: String?
    var name: String?
    var year: Int
    var rating: Double
    var description: String?
    var genres = [String]()
    var image_url: String?
    
    init?(dict: [String: AnyObject]) {
        guard let id = dict["id"] as? Int else {return nil}
        self.id = id
        self.localized_name = dict["localized_name"] as? String
        self.name = dict["name"] as? String
        self.year = dict["year"] as? Int ?? 0
        self.rating = dict["rating"] as? Double ?? 0.0
        self.description = dict["description"] as? String
        self.genres = dict["genres"] as? [String] ?? []
        self.image_url = dict["image_url"] as? String
    }
}


//MARK: - Rating
enum RatingValue: String {

    case high
    case medium
    case low
}

//MARK: - Extension
extension Film {
    var ratingValue: RatingValue? {
        if  rating != 0 && rating >= 7 {
            return RatingValue.high
        } else  if rating != 0 && rating < 5 {
            return RatingValue.low
        } else {
            return RatingValue.medium
        }
    }
}
