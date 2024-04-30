//
//  CharactersListViewModel.swift
//  DisneyApp
//
//  Created by Mantas Jakstas on 29/4/24.
//

import Foundation

@MainActor
final class CharactersListViewModel: ObservableObject {

    enum State: Equatable {
        case idle
        case loading
        case loadingError(String)
        case loaded
    }

    @Published var state = State.idle
    @Published var addedToFavourites: [Character]
    @Published var loadedCharacters: [Character] = []

    var nextPage = 1
    private let size = 25

    private let characterService: CharacterServiceProtocol
    private let favouriteService: FavouriteServiceProtocol

    init(
        characterService: CharacterServiceProtocol = CharacterService(),
        favouriteService: FavouriteServiceProtocol = FavouriteService()
    ) {
        self.characterService = characterService
        self.favouriteService = favouriteService
        self.addedToFavourites = Array((try? favouriteService.favouriteCharacters()) ?? Set<Character>()).sortedByPopularity
    }

    func fetchCharacters() async {
        state = .loading
        do {
            let results: CharacterResponse = try await characterService.fetchCharacters(nextPage: nextPage, size: size)
            loadedCharacters.append(contentsOf: results.data)
            state = .loaded
        } catch {
            state = .loadingError(error.localizedDescription)
        }
    }

    func fetchMoreCharacters() async {
        nextPage += 1
        await fetchCharacters()
    }

    func refreshAddedCharacters() {
        addedToFavourites = Array((try? favouriteService.favouriteCharacters()) ?? Set<Character>()).sortedByPopularity
    }
}
