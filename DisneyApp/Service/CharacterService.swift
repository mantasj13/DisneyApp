//
//  CharacterService.swift
//  DisneyApp
//
//  Created by Mantas Jakstas on 29/4/24.
//

import Foundation

protocol CharacterServiceProtocol {
    func fetchCharacters(nextPage: Int, size: Int) async throws -> CharacterResponse
}

final class CharacterService: CharacterServiceProtocol {

    private let api: APIProtocol
    private let service: ServiceURLFactory

    init(
        api: APIProtocol = API(),
        service: ServiceURLFactory = ServiceURLFactory()
    ) {
        self.api = api
        self.service = service
    }

    func fetchCharacters(nextPage: Int, size: Int) async throws -> CharacterResponse {
        guard let characterURL = service.makeCharactersUrl(nextPage: nextPage, size: size) else {
            throw NetworkingError.invalidURL
        }

        return try await api.fetch(url: characterURL)
    }
}
