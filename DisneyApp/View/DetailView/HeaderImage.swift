//
//  HeaderImage.swift
//  DisneyApp
//
//  Created by Mantas Jakstas on 29/4/24.
//

import SwiftUI

struct HeaderImage: View {

    let imageURL: URL

    var body: some View {
        CacheAsyncImage(url: imageURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            case .failure:
                Image(systemName: "person.crop.circle.badge.exclamationmark.fill")
                    .resizable()
                    .frame(width: 120, height: 120)

            @unknown default:
                EmptyView()
            }
        }
    }
}
