//
//  HeaderListView.swift
//  DisneyApp
//
//  Created by Mantas Jakstas on 29/4/24.
//

import SwiftUI

struct HeaderListView: View {

    @ObservedObject var viewModel: CharactersListViewModel

    var body: some View {
        if !viewModel.addedToFavourites.isEmpty {
            VStack(alignment: .leading) {
                Text("^[\(viewModel.addedToFavourites.count) - Favourite character](inflect: true)")
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                    .padding(.top, 12)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(viewModel.addedToFavourites) { char in
                            NavigationLink(
                                destination: CharacterDetailView(
                                    character: char,
                                    onAddedStatusChanged: {
                                        viewModel.refreshAddedCharacters()
                                    }
                                )
                            ) {
                                FavouriteCharacterView(character: char)
                            }
                        }
                    }
                }
            }
            .frame(height: 210)

        }
    }
}
