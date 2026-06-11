//
//  APIClient.swift
//  UnaPieza
//
//  Created by Fede Garcia on 11/06/2026.
//

import Foundation

struct APIClient {
    let baseURL: URL
    var session: URLSession = .shared
    var decoder: JSONDecoder = JSONDecoder()
    
    func excecute<Response>(_ requestModel: APIRequest<Response>) async throws -> Response {
        do {
            let request = try requestModel.makeURLRequest(baseURL: baseURL)
            
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            guard (200..<300).contains(httpResponse.statusCode) else {
                throw NetworkError.httpStatus(code: httpResponse.statusCode)
            }
            
            return try decoder.decode(Response.self, from: data)
        } catch {
            let mapped = NetworkErrorMapper.map(error)
            throw mapped
        }

    }
}
