//
//  ServiceConstants.swift
//  MoviesFinder
//
//  Created by Long Vo on 15/03/2023.
//

import Foundation
import Alamofire

enum API {
    case getFilmList(String, Int)
    
    var url: String {
        switch self {
        case .getFilmList(let name, let page):
            return "http://www.omdbapi.com/?apikey=\(APIKey)&s=\(name)&type=movie&page=\(page)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getFilmList:
            return .get
        }
    }
    
    var bodyRequest: [String: Any]? {
        switch self {
        case .getFilmList(_):
            return nil
        }
    }
    
    var APIKey: String {
        return KeyManager.shared.APIKey
    }
    
}
