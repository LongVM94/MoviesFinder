//
//  APIService.swift
//  MoviesFinder
//
//  Created by Long Vo on 15/03/2023.
//

import Foundation
import Alamofire

class APIService {
    static let share: APIService = APIService()
    
    func request<T: Codable>(_ api: API, responseObjectType: T.Type , success: @escaping (T) -> Void,
                             failure: @escaping (String) -> Void) {
        print("api.url \(api.url)")
        AF.request(api.url , method: api.method,  parameters: api.bodyRequest, encoding: JSONEncoding.default).response { response in
            guard let data = response.data else {
                failure("Not found")
                return
            }
            switch response.result {
            case .success(let responseData):
                do {
                    let decoder = JSONDecoder()
                    let decodeData = try decoder.decode(T.self, from: data)
                    
                    success(decodeData)
                } catch let error {
                    failure(error.localizedDescription)
                }
            case .failure(let e):
                failure(e.localizedDescription)
            }
        }
        
    }
}
