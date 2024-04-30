//
//  CharactersListView.swift
//  DisneyApp
//
//  Created by Mantas Jakstas on 29/4/24.
//

import SwiftUI

struct CharactersListView: View {

    @StateObject private var viewModel = CharactersListViewModel()
    
    var body: some View {
        NavigationStack {
            if case .loadingError(let errorMessage) = viewModel.state {
                ContentUnavailableView {
                    Label("\(errorMessage)", systemImage: "xmark.octagon.fill")
                } actions: {
                    Button("Retry") {
                        Task {
                            await viewModel.fetchCharacters()
                        }
                    }
                }
            } else {
                ZStack {
                    VStack(alignment: .leading, spacing: 0) {
                        HeaderListView(viewModel: viewModel)
                            .padding(.leading, 20)
                        ScrollView(.vertical, showsIndicators: false) {
                            LazyVStack {
                                ForEach(viewModel.loadedCharacters) { character in
                                    NavigationLink(
                                        destination: CharacterDetailView(
                                            character: character,
                                            onAddedStatusChanged: {
                                                viewModel.refreshAddedCharacters()
                                            }
                                        )
                                    ) {
                                        CharacterRowView(
                                            character: character
                                        )
                                        .onAppear() {
                                            if character == viewModel.loadedCharacters.last {
                                                Task {
                                                    await viewModel.fetchMoreCharacters()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            if viewModel.state == .loading {
                                ProgressView()
                                    .tint(Color.customBlue)
                                    .padding()
                            }
                        }
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                Image(.disney)
                                    .resizable()
                                    .frame(width: 75, height: 60)
                                    .padding()
                            }
                        }
                        .padding()
                    }
                }
                .containerRelativeFrame([.horizontal, .vertical])
                .background(Color.background)
            }
        }
        .onAppear() {
            if viewModel.loadedCharacters.isEmpty {
                Task {
                    await viewModel.fetchCharacters()
                }
            }
        }
    }
}

#Preview {
    CharactersListView()
}
