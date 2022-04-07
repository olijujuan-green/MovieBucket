//
//  NetworkManager.swift
//  MovieBucket
//
//  Created by Olijujuan Green on 5/21/20.
//  Copyright © 2020 Olijujuan Green. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared   = NetworkManager()
    let cache           = NSCache<NSString, UIImage>()
    private init() {}
    
    func getMovies(for queryString: String, page: Int, completed: @escaping([Movie]?, MBError?) -> Void ) {
        let endpoint = "\(API.baseURL)\(queryString)?api_key=\(API.apiKey)&language=en-US&page=\(page)&region=us"
        guard let url = URL(string: endpoint) else { return }
        print(url)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil, .noInternet)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, .serverError)
                return
            }
            
            guard let data = data else {
                completed(nil, .invalidData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(Result.self, from: data)
                let movies = result.movies
                completed(movies, nil)
            } catch {
                completed(nil, .invalidData)
            }
        }
        task.resume()
    }
    
    
    
    
    func getMovieDetails(for movieId: Int, completed: @escaping(Movie?, MBError?) -> Void) {
        let endpoint = "\(API.baseURL)/\(movieId)?api_key=\(API.apiKey)&language=en-US"
        guard let url = URL(string: endpoint) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil, .noInternet)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, .serverError)
                return
            }
            
            guard let data = data else {
                completed(nil, .invalidData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movie = try decoder.decode(Movie.self, from: data)
                completed(movie, nil)
            } catch {
                completed(nil, .invalidData)
            }
        }
        task.resume()
    }
    
    
    
    
    func getCredits(for movieId: Int, completed: @escaping([Actor]?, MBError?) -> Void) {
        let endpoint = "\(API.baseURL)/\(movieId)/credits?api_key=\(API.apiKey)"
        let url = URL(string: endpoint)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil, .noInternet)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, .serverError)
                return
            }
            
            
            guard let data = data else {
                completed(nil, .invalidData)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : Any]
                let cast = json["cast"] as! [Any]
                var actors: [Actor] = []
                
                for dict in cast {
                    let dictionary          = dict as! [String : Any]
                    
                    let character           = dictionary["character"] as? String
                    let gender              = dictionary["gender"] as? Int
                    let id                  = dictionary["id"] as? Int
                    let name                = dictionary["name"] as? String
                    let profilePath         = dictionary["profile_path"] as? String
                    
                    if let character = character, let gender = gender, let id = id, let name = name, let profilePath = profilePath {
                        let actor = Actor(character: character, gender: gender, id: id, name: name, profilePath: profilePath)
                        actors.append(actor)
                    }
                    completed(actors, nil)
                }
                                
            } catch {
                completed(nil, .invalidData)
                return
            }
        }.resume()
    }
    
    
    
}
