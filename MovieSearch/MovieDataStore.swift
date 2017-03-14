//
//  MovieDataStore.swift
//  MovieSearch
//
//  Created by Alessandro Musto on 3/10/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import Foundation
import UIKit

class MovieDataStore {

  static let sharedInstance = MovieDataStore()
  fileprivate init() {}

  var movies: [Movie] = []
  var movieDetail: MovieDetail!

  func getMovies(withTitle title: String, with completion: @escaping () -> ()) {

    OmbdAPIClient.getSearchResults(withTitle: title) { (movieArray) in
      self.movies.removeAll()
      for dict in movieArray {
          let movie = Movie(movies: dict)
          self.movies.append(movie)
      }
      completion()

    }
  }

  func downloadImage(withURL url: URL, with completion: @escaping (UIImage) -> ()) {
    let session = URLSession.shared
    let task = session.dataTask(with: url) { (data, response, error) in

        if let imageData = data {
          DispatchQueue.main.async {
            if let image = UIImage(data: imageData) {
              completion(image)
            }
          }
        }
      }
    task.resume()
  }

  func getMovieDetail(withID id: String, with completion: @escaping () -> ()) {
    OmbdAPIClient.getMovieDetail(withID: id) { (dict) in
      let movie = MovieDetail(details: dict)
      self.movieDetail = movie
      completion()
    }

  }



  
}
