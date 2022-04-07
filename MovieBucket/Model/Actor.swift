//
//  Actor.swift
//  MovieBucket
//
//  Created by Olijujuan Green on 6/1/20.
//  Copyright © 2020 Olijujuan Green. All rights reserved.
//

import Foundation

struct Actor: Codable {
    
    var character       : String
    var gender          : Int
    var id              : Int
    var name            : String
    var profilePath     : String
    
}




struct Credits: Codable {
    var cast : [Actor]
}
