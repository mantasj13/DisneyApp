//
//  FavouriteServiceMock.swift
//  DisneyAppTests
//
//  Created by Mantas Jakstas on 29/4/24.
//

import Foundation
@testable import DisneyApp

final class FavouriteMockService: FavouriteServiceProtocol {

    var stubbedFavouriteCharacters: Set<Character> = []

    func addCharacter(_ character: Character) throws {}
    func removeCharacter(_ character: Character) throws {}
    
    func favouriteCharacters() throws -> Set<DisneyApp.Character> {
        stubbedFavouriteCharacters
    }
    
    func isOnFavourite(_ character: DisneyApp.Character) -> Bool {
        stubbedFavouriteCharacters.contains(character)
    }
}
