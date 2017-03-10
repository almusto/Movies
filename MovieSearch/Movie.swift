//
//  Movie.swift
//  MovieSearch
//
//  Created by Alessandro Musto on 3/10/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import Foundation

let baseURL = "http://www.omdbapi.com/?"

class Movie {
  let imdbID: String
  let posterURL: URL?
  let type: String

  init(movies: [String:Any]) {
    imdbID = movies["imdbID"] as? String ?? ""
    type = movies["Type"] as? String ?? ""
    let poster = movies["Poster"] as? String ?? ""
    posterURL = URL(string: poster)
  }

}
