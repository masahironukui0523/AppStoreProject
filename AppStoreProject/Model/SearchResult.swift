//
//  SearchResult.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/03/04.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackId: Int
    let trackName: String
    let primaryGenreName: String
    let artworkUrl100: String
    let screenshotUrls: [String]
    var averageUserRating: Float?
    let description: String
    var releaseNotes: String?
    var formattedPrice: String?
}
