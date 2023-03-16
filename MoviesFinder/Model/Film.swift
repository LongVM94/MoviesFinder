//
//  Film.swift
//  MoviesFinder
//
//  Created by Long Vo on 15/03/2023.
//

import Foundation

struct Search: Codable {
    var search: [Film]
    var totalResults: String
    var response: String


    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults = "totalResults"
        case response = "Response"
    }
    
    init() {
        search = []
        totalResults = "0"
        response = "False"
    }
}

struct Film: Codable {
    var title: String
    var year: String
    var imdbID: String
    var poster: String
    var type: String


    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID = "imdbID"
        case poster = "Poster"
        case type = "Type"
    }
}

