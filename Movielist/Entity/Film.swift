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
    var year: Int?
    var rating: Double?
    var description: String?
    var genres = [String]()
    var image_url: String?
    
    init?(dict: [String: AnyObject]) {

//        guard let id = dict["id"] as? Int,
//        let localized_name = dict["localized_name"] as? String,
//        let name = dict["name"] as? String,
//        let year = dict["year"] as? Int,
//        let rating = dict["rating"] as? Double,
//        let description = dict["description"] as? String,
//        let genres = dict["genres"] as? [String],
//        let image_url = dict["image_url"] as? String else {return nil}
//
//        self.id = id
//        self.localized_name = localized_name
//        self.name = name
//        self.year = year
//        self.rating = rating
//        self.description = description
//        self.genres = genres
//        self.image_url = image_url
        
        
        guard let id = dict["id"] as? Int else {return nil}
        self.id = id
        self.localized_name = dict["localized_name"] as? String
        self.name = dict["name"] as? String
        self.year = dict["year"] as? Int
        self.rating = dict["rating"] as? Double
        self.description = dict["description"] as? String
        self.genres = dict["genres"] as? [String] ?? []
        self.image_url = dict["image_url"] as? String
    }
}


//MARK: - Rating
//enum RatingValue: String {
//
//    case high
//    case medium
//    case low
//}

//extension Film {
//    var ratingValue: RatingValue? {
//        guard let rating = self.rating else { return nil }
//
//        if rating >= 7.0 {
//            return RatingValue.high
//        } else if rating < 5.0 {
//            return RatingValue.low
//        } else {
//            return RatingValue.medium
//        }
//    }
//}
