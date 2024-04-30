//
//  CharacterDetailViewModelTests.swift
//  DisneyAppTests
//
//  Created by Mantas Jakstas on 29/4/24.
//

import XCTest
@testable import DisneyApp

final class CharacterDetailViewModelTests: XCTestCase {

    private var sut: CharacterDetailViewModel!
    var favouriteService: FavouriteService!
    private var character: Character!

    override func setUp() {
        character =  Character(id: 2, name: "Name", imageURL: "", films: [""])
        favouriteService = FavouriteService()
        sut = CharacterDetailViewModel(character: character, favouriteService: favouriteService, onAddedStatusChanged: {})
    }

    override func tearDown() {
        sut = nil
    }

    func test_givenAddedStatusChanged_whenOnDismiss_thenOnAddedStatusChangedCalled() {

        // Given
        let onAddedStatusChangedExpectation = expectation(description: "onAddedStatusChanged should be called")

        //When
        let vm = CharacterDetailViewModel(character: character, favouriteService: favouriteService) {
            onAddedStatusChangedExpectation.fulfill()
        }

        //Then
        vm.isAdded.toggle()
        vm.onDismiss()

        wait(for: [onAddedStatusChangedExpectation], timeout: 1)
    }

    func test_givenAddedStatusNotChanged_whenOnDismiss_thenOnAddedStatusChangeNotdCalled() {

        // Given
        let onAddedStatusChangedExpectation = expectation(description: "onAddedStatusChanged should be called")
        onAddedStatusChangedExpectation.isInverted = true

        //When
        let vm = CharacterDetailViewModel(character: character, favouriteService: favouriteService) {
            onAddedStatusChangedExpectation.fulfill()
        }

        //Then
        vm.isAdded.toggle()
        vm.isAdded.toggle()
        vm.onDismiss()

        wait(for: [onAddedStatusChangedExpectation], timeout: 1)
    }
}
