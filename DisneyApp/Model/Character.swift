//
//  Character.swift
//  DisneyApp
//
//  Created by Mantas Jakstas on 29/4/24.
//
import Foundation

struct CharacterResponse: Codable {
    let info: Info
    let data: [Character]
}

struct Info: Codable {
    let totalPages, count: Int
    let previousPage, nextPage: String?
}

struct Character: Codable, Hashable, Identifiable {
    let id: Int
    let name: String
    let imageURL: String?
    let films: [String]?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
        case imageURL = "imageUrl"
        case films
    }

    var popularity: Int {
        films?.count ?? 0
    }
}
