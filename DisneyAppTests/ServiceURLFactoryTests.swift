//
//  ServiceURLFactoryTests.swift
//  DisneyAppTests
//
//  Created by Mantas Jakstas on 29/4/24.
//

import XCTest
@testable import DisneyApp

final class ServiceURLFactoryTests: XCTestCase {

    func test_MakeURL() {
        // Given
        let sut = ServiceURLFactory(baseURL: URL(string: "https://api.disneyapi.dev")!)

        // When
        let url = sut.makeCharactersUrl(nextPage: 1, size: 50)

        //Then
        XCTAssertEqual(url, URL(string: "https://api.disneyapi.dev/character?page=1&pageSize=50"))
    }

    func test_InvalidURL() {
        // Given
        let sut = ServiceURLFactory(baseURL: URL(string: "https://api.disneyapi.dev")!)

        // When
        let url = sut.makeCharactersUrl(nextPage: 1, size: 50)

        //Then
        XCTAssertNotEqual(url, URL(string: "https://disneyapi.dev/character?page=1&pageSize=50"))
    }

}
