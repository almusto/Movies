//
//  Movie.swift
//  MovieSearch
//
//  Created by Alessandro Musto on 3/10/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import Foundation


class Movie {
    let title: String
    let imdbID: String
    let posterURL: URL?
    let type: String

    init(movies: [String:Any]) {
        imdbID = movies["imdbID"] as? String ?? ""
        type = movies["Type"] as? String ?? ""
        title = movies["Title"] as? String ?? ""
        let poster = movies["Poster"] as? String ?? ""
        posterURL = URL(string: poster)
    }

}

class MovieDetail {
    let shortPlot: String
    let longPlot: String?
    let yearReleased: String
    let director: String
    let writer: String
    let actors: String
    let metaScore: String
    let imdbScore: String
    let posterURL: String

    init(details: [String:Any]) {
        shortPlot = details["Plot"] as? String ?? ""
        yearReleased = details["Year"] as? String ?? ""
        director = details["Director"] as? String ?? ""
        writer = details["Writer"] as? String ?? ""
        actors = details["Actors"] as? String ?? ""
        metaScore = details["Metascore"] as? String ?? ""
        imdbScore = details["imdbRating"] as? String ?? ""
        longPlot = nil
        posterURL = details["Poster"] as? String ?? ""
    }
}
