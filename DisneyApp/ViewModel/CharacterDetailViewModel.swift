//
//  CharacterDetailViewModel.swift
//  DisneyApp
//
//  Created by Mantas Jakstas on 29/4/24.
//

import Foundation

final class CharacterDetailViewModel: ObservableObject {

    let character: Character

    private let favouriteService: FavouriteServiceProtocol
    private let onAddedStatusChanged: () -> ()
    private let isOnFavouritesInitially: Bool

    @Published var isAdded: Bool {
        didSet {
            if isAdded {
                try? favouriteService.addCharacter(character)
            } else {
                try? favouriteService.removeCharacter(character)
            }
        }
    }

    init(character: Character, favouriteService: FavouriteServiceProtocol = FavouriteService(), onAddedStatusChanged: @escaping () -> ()) {
        self.character = character
        self.favouriteService = favouriteService
        self.onAddedStatusChanged = onAddedStatusChanged
        self.isAdded = favouriteService.isOnFavourite(character)
        self.isOnFavouritesInitially = favouriteService.isOnFavourite(character)
    }

    func onDismiss() {
        if isOnFavouritesInitially != favouriteService.isOnFavourite(character) {
            onAddedStatusChanged()
        }
    }
}
