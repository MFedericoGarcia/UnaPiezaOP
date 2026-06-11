//
//  APIRoute.swift
//  UnaPieza
//
//  Created by Fede Garcia on 11/06/2026.
//

import Foundation

struct URLConstants {
    static let devilFruits: URL = URL(string: "https://api.api-onepiece.com/v2/fruits/en")!
    static let allCharacters: URL = URL(string: "https://api.api-onepiece.com/v2/characters/en")!
    static let characterImage: URL = URL(string: "https://www.optcgapi.com/api/sets/filtered/?card_name=")!
}

enum APIRoute {
    case devilFruits
    case allCharacters
    case characterImage(String)
    
    var path: String {
        switch self {
        case .devilFruits:
            return ""
        case .allCharacters:
            return ""
        case .characterImage(let name):
            return  name
        }
    }
}
