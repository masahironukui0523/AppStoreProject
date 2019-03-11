//
//  AppGroup.swift
//  AppStoreProject
//
//  Created by 抜井正寛 on 2019/03/11.
//  Copyright © 2019 Masahiro Nukui. All rights reserved.
//

import Foundation

struct AppGroup: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    let name, artistName, artworkUrl100: String
}
