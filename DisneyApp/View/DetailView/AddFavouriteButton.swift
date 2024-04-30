//
//  AddFavouriteButton.swift
//  DisneyApp
//
//  Created by Mantas Jakstas on 29/4/24.
//

import SwiftUI

struct AddFavouriteButton: View {
    @Binding var isAdded: Bool
    let removeAction: () -> Void

    var body: some View {
        Button(action: {
            if isAdded {
                removeAction()
            } else {
                isAdded.toggle()
            }
        }) {
            Text(
                isAdded
                    ? "Remove from favourites"
                    : "Add to favourites"
            )
                .font(.headline)
                .fontWeight(.semibold)
        }
        .frame(height: 55)
        .frame(width: 270)
        .foregroundColor(.white)
        .background(isAdded ? .black : .customRed)
        .cornerRadius(8)
        .shadow(color: .customBlue, radius: 16)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(
                    isAdded ? Color.red : .pink,
                    style: StrokeStyle(lineWidth: 2)
                )
        )
        .padding(.horizontal, 2)
    }
}
