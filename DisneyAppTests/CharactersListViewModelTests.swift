//
//  CharactersListViewModelTests.swift
//  DisneyAppTests
//
//  Created by Mantas Jakstas on 29/4/24.
//

import XCTest
@testable import DisneyApp

final class CharactersListViewModelTests: XCTestCase {

    private var sut: CharactersListViewModel!
    private var favouriteMockService: FavouriteMockService!
    var mockAPI: APIMock!

    @MainActor
    override func setUp() {
        mockAPI = APIMock(fileName: "MarvelCharacters")
        favouriteMockService = FavouriteMockService()
        sut = CharactersListViewModel(characterService: CharacterService(api: mockAPI, service: ServiceURLFactory()), favouriteService: favouriteMockService)
    }

    override func tearDown() {
        sut = nil
    }

    @MainActor
    func test_FetchCharacters() async {

        //Given
        mockAPI.fetchFailure = false
        await sut.fetchCharacters()

        //When
        switch sut.state {
            //Then
        case .loaded:
            XCTAssertEqual(sut.loadedCharacters.count, 20)
            XCTAssertEqual(sut.loadedCharacters[0].name, "Achilles")
            XCTAssertEqual(sut.loadedCharacters[1].id, 18)
        default:
            XCTFail("Unexpected state")
        }
    }

    @MainActor
    func test_FetchMoreCharacters() async {

        //Given
        mockAPI.fetchFailure = false
        let initialCharacters = Character(id: 2, name: "Name", imageURL: "", films: [""])
        await sut.fetchCharacters()
        sut.loadedCharacters = [initialCharacters]

        //When
        await sut.fetchMoreCharacters()

        //Then
        switch sut.state {
        case .loaded:
            XCTAssertEqual(sut.loadedCharacters.count, 21, "Should return 21, 20 of the json and the initial initialCharacters")
            XCTAssertEqual(sut.nextPage, 2)
        default:
            XCTFail("Unexpected state")
        }
    }

    @MainActor
    func test_FetchHeroesFailure() async {

        // Given
        mockAPI.fetchFailure = true

        // When
        await sut.fetchCharacters()

        // Then
        switch sut.state {
        case .loadingError(let errorMessage):
            XCTAssertEqual(errorMessage.localizedLowercase, "the operation couldn’t be completed. (fetcherror error 0.)")
        default:
            XCTFail("Expected loading error state")
        }
    }

    @MainActor
    func testRefreshAddedCharacters() throws {

        // Given
        let favouriteCharacter: Set<Character> = [Character(id: 3, name: "Character", imageURL: "", films: [""])]
        favouriteMockService.stubbedFavouriteCharacters = favouriteCharacter

        // When
        sut.refreshAddedCharacters()

        // Then
        XCTAssertEqual(sut.addedToFavourites, Array(favouriteCharacter))
    }

    @MainActor
    func test_RefreshAddedCharacters_SortsByPopularity() async {
        
        // Given
        let favouriteCharacter1 = Character(id: 1, name: "Character 1", imageURL: "", films: ["film1","film2","film3"])
        let favouriteCharacter2 = Character(id: 2, name: "Character 2", imageURL: "", films: ["film1","film2"])
        let favouriteCharacter3 = Character(id: 3, name: "Character 3", imageURL: "", films: ["film1"])
        let favouriteCharacters: Set<Character> = [favouriteCharacter1, favouriteCharacter2, favouriteCharacter3]
        favouriteMockService.stubbedFavouriteCharacters = favouriteCharacters

        // When
        sut.refreshAddedCharacters()

        // Then
        XCTAssertEqual(sut.addedToFavourites, [favouriteCharacter1, favouriteCharacter2, favouriteCharacter3])
    }
}
