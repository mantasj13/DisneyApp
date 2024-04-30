//
//  CacheAsyncImage.swift
//  DisneyApp
//
//  Created by Mantas Jakstas on 29/4/24.
//

import Foundation
import SwiftUI

struct CacheAsyncImage<T>: View where T: View {

    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> T

    init (
        url: URL,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> T)
    {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }

    var body: some View {
        if let cached = ImageCache[url] {
            content (.success(cached))
        } else {
            AsyncImage(
                url: url,
                scale: scale,
                transaction: transaction
            ) { phase in
                cacheAndRender (phase: phase)
            }
        }
    }

    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            ImageCache[url] = image
        }
        return content(phase)
    }
}

fileprivate class ImageCache {
    static private var cache: [URL: Image] = [:]
    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache [url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}
