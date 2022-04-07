//
//  Movie.swift
//  MovieBucket
//
//  Created by Olijujuan Green on 5/21/20.
//  Copyright © 2020 Olijujuan Green. All rights reserved.
//

import Foundation

struct Movie: Codable, Hashable {
    let adult       : Bool
    let id          : Int
    var revenue     : Int?
    var budget      : Int?
    var runtime     : Int?
    let voteAverage : Double
    var homepage    : String?
    let title       : String
    let overview    : String
    let posterPath  : String
    let backdropPath: String
    let releaseDate : String
    var tagline     : String?
}




struct Result: Codable {
    var movies : [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}



