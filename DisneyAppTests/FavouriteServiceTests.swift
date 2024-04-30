//
//  FavouriteServiceTests.swift
//  DisneyAppTests
//
//  Created by Mantas Jakstas on 29/4/24.
//

import XCTest
@testable import DisneyApp

final class FavouriteServiceTests: XCTestCase {

    private var sut: FavouriteServiceProtocol!

    override func setUp() {
        sut = FavouriteService()
    }

    override func tearDown() {
        sut = nil
    }

    func test_AddCharacterSuccessfully() {
        let character = Character(id: 2, name: "Name", imageURL: "", films: [""])

        XCTAssertNoThrow(try sut.addCharacter(character))
        XCTAssertTrue(sut.isOnFavourite(character))
    }

    func test_RemoveCharacterSuccessfully() throws {
        // Given
        let character = Character(id: 2, name: "Name", imageURL: "", films: [""])

        //When
        try sut.removeCharacter(character)

        // Then
        XCTAssertNoThrow(try sut.removeCharacter(character))
        XCTAssertFalse(sut.isOnFavourite(character))
    }

    func test_FavouritesNotEmpty() throws {
        // Given
        let character = Character(id: 2, name: "Name", imageURL: "", films: [""])

        // When
        try sut.addCharacter(character)
        let addedCharacter = try? sut.favouriteCharacters()

        // Then
        XCTAssertNotNil(addedCharacter)
    }

    func test_NoFavouriteCharacterAfterRemoveAction() throws {
        // Given
        let character = Character(id: 2, name: "Name", imageURL: "", films: [""])

        // When
        try sut.addCharacter(character)
        try sut.removeCharacter(character)

        // Then
        XCTAssertFalse(sut.isOnFavourite(character))
    }
}
