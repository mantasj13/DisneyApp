//
//  NetworkingError.swift
//  DisneyApp
//
//  Created by Mantas Jakstas on 29/4/24.
//

import Foundation

enum NetworkingError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidStatusCode(statusCode: Int)
    case invalidDecodedData
    case unownedError(description: String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided is invalid"
        case .invalidResponse:
            return "The response is invalid"
        case .invalidStatusCode(let statusCode):
            return "Something when wrong, status code: \(statusCode)"
        case .invalidDecodedData:
            return "Invalid decoding data"
        case .unownedError(let description):
            return "Error: \(description)"
        }
    }
}
