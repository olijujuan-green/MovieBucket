//
//  MBError.swift
//  MovieBucket
//
//  Created by Olijujuan Green on 5/21/20.
//  Copyright © 2020 Olijujuan Green. All rights reserved.
//

import Foundation

enum MBError: String, Error {
    case noInternet                 = "An error occured. Check connection and try again."
    case serverError                = "Invalid response from server. Try again."
    case invalidData                = "Invalid data. Try again"
    case unableToFavorite           = "Can't add movie to favorites. Try again."
    case movieAlreadyInFavorites    = "Movie is already in your favorites."
}
