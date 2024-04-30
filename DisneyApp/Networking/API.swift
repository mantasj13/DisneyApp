//
//  API.swift
//  DisneyApp
//
//  Created by Mantas Jakstas on 29/4/24.
//

import Foundation

protocol APIProtocol {
    func fetch<T: Decodable> (url: URL) async throws -> T
}

final class API: APIProtocol {

    private let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func fetch<T: Decodable> (url: URL) async throws -> T {

        let (data, response) = try await urlSession.data(from: url)

        guard let response = response as? HTTPURLResponse else {
            throw NetworkingError.invalidResponse
        }

        guard 200...299 ~= response.statusCode else {
            throw NetworkingError.invalidStatusCode(statusCode: response.statusCode)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            let response = try decoder.decode(T.self, from: data)
            return response
        } catch {
            throw NetworkingError.invalidDecodedData
        }
    }
}
