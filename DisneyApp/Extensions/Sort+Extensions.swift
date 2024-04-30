//
//  Sort+Extensions.swift
//  DisneyApp
//
//  Created by Mantas Jakstas on 29/4/24.
//

import Foundation

extension [Character] {
    var sortedByPopularity: [Character] {
        sorted(by: { c1, c2 in
            c1.popularity > c2.popularity
        })
    }
}
