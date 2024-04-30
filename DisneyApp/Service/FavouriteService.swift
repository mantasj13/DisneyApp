//
//  FavouriteService.swift
//  DisneyApp
//
//  Created by Mantas Jakstas on 29/4/24.
//

import Foundation
import SwiftUI

protocol FavouriteServiceProtocol {
    func addCharacter(_ character: Character) throws
    func removeCharacter(_ character: Character) throws
    func favouriteCharacters() throws -> Set<Character>
    func isOnFavourite(_ character: Character) -> Bool
}

final class FavouriteService: FavouriteServiceProtocol {

    @AppStorage("favourites") private var addedCharacters: Data?

    func addCharacter(_ character: Character) throws {
        var previous = try favouriteCharacters()
        previous.insert(character)
        let addedData = try JSONEncoder().encode(previous)
        addedCharacters = addedData
    }

    func removeCharacter(_ character: Character) throws {
        var previous = try favouriteCharacters()
        previous.remove(character)
        let addedCharacterData = try JSONEncoder().encode(previous)
        addedCharacters = addedCharacterData
    }

    func favouriteCharacters() throws -> Set<Character> {
        guard let savedAddedCharacters = addedCharacters else {
            return []
        }
        let favouriteCharacters = try JSONDecoder().decode(Set<Character>.self, from: savedAddedCharacters)
        return favouriteCharacters
    }

    func isOnFavourite(_ character: Character) -> Bool {
        (try? favouriteCharacters().contains(character)) ?? false
    }
}
