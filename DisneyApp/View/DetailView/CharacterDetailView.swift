//
//  CharacterDetailView.swift
//  DisneyApp
//
//  Created by Mantas Jakstas on 29/4/24.
//

import SwiftUI

struct CharacterDetailView: View {

    @Environment (\.dismiss) private var dismiss
    @State private var showAlert = false
    @State private var isAdded: Bool

    @StateObject private var viewModel: CharacterDetailViewModel
    private let favouriteService: FavouriteServiceProtocol

    init(character: Character, favouriteService: FavouriteServiceProtocol = FavouriteService(), onAddedStatusChanged: @escaping () -> ()) {
        _viewModel = StateObject(wrappedValue: CharacterDetailViewModel(character: character, favouriteService: favouriteService, onAddedStatusChanged: onAddedStatusChanged))

        self.favouriteService = favouriteService
        _isAdded = State(initialValue: favouriteService.isOnFavourite(character))
    }

    var body: some View {
        VStack {
            if let imageUrl = viewModel.character.imageURL, let url = URL(string: imageUrl) {
                CacheAsyncImage(
                    url: url,
                    transaction: Transaction(animation: .easeInOut)
                ) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .transition(.scale(scale: 0.1, anchor: .center))
                    case .failure:
                        Image(systemName: "wifi.slash")
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 300, height: 300)
                .background(Color.gray)
                .clipShape(Circle())
            }

            Text(viewModel.character.name)
                .multilineTextAlignment(.center)
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .padding(.vertical, 15)

            AddFavouriteButton(isAdded: $viewModel.isAdded) {
                showAlert = true
            }
            Spacer()
        }
        .padding(.vertical, 20)
        .containerRelativeFrame([.horizontal, .vertical])
        .background(Gradient(colors: [.background, .background, .customBlue]).opacity(1))
        .padding(.vertical, 10)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Alert"),
                message: Text("Do you want to remove \(viewModel.character.name) from favourites?"),
                primaryButton: .destructive(Text("Yes")) {
                    viewModel.isAdded = false
                    dismiss()
                },
                secondaryButton: .cancel(Text("No"))
            )
        }

        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image(.disney)
                    .resizable()
                    .frame(width: 75, height: 60)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                }
            }
        }
        .onDisappear {
            viewModel.onDismiss()
        }
    }
}
