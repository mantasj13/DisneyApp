//
//  APIMock.swift
//  DisneyAppTests
//
//  Created by Mantas Jakstas on 29/4/24.
//

import Foundation
@testable import DisneyApp

final class APIMock: APIProtocol {

    private let fileName: String
    var fetchFailure = true

    init(fileName: String) {
        self.fileName = fileName
    }

    func fetch<T: Decodable>(url: URL) async throws -> T {

        if fetchFailure {
            throw NSError(domain: "fetcherror", code: 0)
        } else {
            guard let url = Bundle(for: Self.self).url(forResource: fileName, withExtension: "json") else {
                throw NetworkingError.invalidURL
            }

            let data = try Data(contentsOf: url)

            guard let response = try? JSONDecoder().decode(T.self, from: data) else {
                throw NetworkingError.invalidDecodedData
            }
            return response
        }
    }
}
