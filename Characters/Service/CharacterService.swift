//
//  CharacterService.swift
//  UnaPieza
//
//  Created by Fede Garcia on 11/06/2026.
//

import Foundation

protocol CharacterServiceProtocol {
    func fetchCharacters()  async throws -> [Character]
}

struct CharacterService: CharacterServiceProtocol {
    private let client: APIClient
    
    init() {
        self.client = APIClient(baseURL: URLConstants.allCharacters)
    }
    
    func fetchCharacters() async throws -> [Character] {
        let requestModel = APIRequest<[Character]>(method: .get, path: .allCharacters)
        return try await client.excecute(requestModel)
    }
}
