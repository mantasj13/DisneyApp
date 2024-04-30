//
//  ServiceURLFactory.swift
//  DisneyApp
//
//  Created by Mantas Jakstas on 29/4/24.
//

import Foundation

final class ServiceURLFactory {

    private let baseURL: URL

    init(baseURL: URL = Constants.baseURL) {
        self.baseURL = baseURL
    }

    func makeCharactersUrl(nextPage: Int, size: Int) -> URL? {
        URL(string: "\(Constants.baseURL)/character?page=\(nextPage)&pageSize=\(size)")
    }
}
