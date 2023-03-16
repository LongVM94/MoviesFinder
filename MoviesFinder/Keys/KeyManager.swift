//
//  KeyManager.swift
//  MoviesFinder
//
//  Created by Long Vo on 15/03/2023.
//

import Foundation

class KeyManager {
    fileprivate static var instance: KeyManager!
    private var dictionary: NSDictionary?
    static var shared : KeyManager {
        self.instance = (self.instance ?? KeyManager())
        return self.instance
    }
    
    init() {
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            dictionary = NSDictionary(contentsOfFile: path)
        }
    }
    
    var APIKey: String {
        let key = dictionary?.value(forKey: "APIKey") as? String ?? ""
        return key
    }
}
