//
//  CharacterRowView.swift
//  DisneyApp
//
//  Created by Mantas Jakstas on 29/4/24.
//

import SwiftUI

struct CharacterRowView: View {

    let character: Character

    var body: some View {
        HStack {
            Group {
                if let imageUrl = character.imageURL, let url = URL(string: imageUrl) {
                    CacheAsyncImage(url: url, transaction: Transaction(animation: .easeInOut)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                        case .failure:
                            Image(systemName: "person.crop.circle.badge.exclamationmark.fill")
                                .frame(width: 60, height: 120)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(systemName: "person.crop.circle.badge.exclamationmark.fill")
                        .frame(width: 60, height: 120)
                }
            }
            .clipShape(Circle())
            .frame(width: 55, height: 55)
            .padding(.all, 16)

            Text(character.name)
                .foregroundColor(.white)
                .font(.headline)
                .fontWeight(.bold)
                .lineLimit(1)

            Spacer()

            Image(systemName: "chevron.right")
                .padding(.horizontal, 16)
                .foregroundColor(Color.white)
        }
        .background(Color.grayLight)
        .cornerRadius(8.0)
    }
}
