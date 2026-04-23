//
//  JSONCall.swift
//  UnaPieza
//
//  Created by Fede Garcia on 22/04/2026.
//

import Foundation

func loadData<T: Codable>(url: String) async -> T {
    guard let url = URL(string: url ) else {
        print("Invalid URL")
        return [] as! T
    }
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase

    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        if let decodedResponse = try? decoder.decode(T.self, from: data) {
            return decodedResponse
        }
    } catch {
        print("Invalid data")
    }
    
    return [] as! T
}
