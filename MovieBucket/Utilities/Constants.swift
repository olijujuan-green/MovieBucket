//
//  Constants.swift
//  MovieBucket
//
//  Created by Olijujuan Green on 5/21/20.
//  Copyright © 2020 Olijujuan Green. All rights reserved.
//

import Foundation

enum QueryStrings {
    static let nowPlaying   = "/now_playing"
    static let popular      = "/popular"
    static let topRated     = "/top_rated"
    static let upcoming     = "/upcoming"
}

enum API {
    static let apiKey       = "432df14a187f605ea96bd15e951e5ff9"
    static let baseURL      = "https://api.themoviedb.org/3/movie"
    static let baseImageURL = "https://image.tmdb.org/t/p/w500"
}
