//
//  DevilFruitService.swift
//  UnaPieza
//
//  Created by Fede Garcia on 11/06/2026.
//

import Foundation

protocol DevilFruitServiceProtocol {
    func fetchFruits()  async throws -> [DevilFruit]
}

struct DevilFruitService: DevilFruitServiceProtocol {
    private let client: APIClient
    
    init() {
        self.client = APIClient(baseURL: URLConstants.devilFruits)
    }
    
    func fetchFruits() async throws -> [DevilFruit] {
        let requestModel = APIRequest<[DevilFruit]>(method: .get, path: .devilFruits)
        return try await client.excecute(requestModel)
    }
    
}
