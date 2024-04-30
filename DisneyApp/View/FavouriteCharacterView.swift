//
//  FavouriteCharacterView.swift
//  DisneyApp
//
//  Created by Mantas Jakstas on 29/4/24.
//

import SwiftUI

struct FavouriteCharacterView: View {

    let character: Character

    var body: some View {
        VStack {
            Group {
                if let imageURL = URL(string: character.imageURL ?? "person.crop.circle.badge.exclamationmark.fill") {
                    CacheAsyncImage(url: imageURL, transaction: Transaction(animation: .easeInOut)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                        case .failure:
                            Image(systemName: "person.crop.circle.badge.exclamationmark.fill")
                                .frame(width: 72, height: 72)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(systemName: "person.crop.circle.badge.exclamationmark.fill")
                        .frame(width: 72, height: 72)
                }
            }
            .clipShape(Circle())
            .frame(width: 72, height: 72)
            .padding(.all, 8)

            VStack {
                Text(character.name)
                    .font(.footnote)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .foregroundColor(.white)

                Spacer()
            }
            .frame(height: 72)
        }
        .frame(maxWidth: 72)
    }
}
