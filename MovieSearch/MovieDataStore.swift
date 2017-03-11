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

  func getMovies(withTitle title: String, with completion: @escaping () -> ()) {

    OmbdAPIClient.getSearchResults(withTitle: title) { (movieArray) in
      self.movies.removeAll()
      for dict in movieArray {
        if dict["Type"] as! String == "movie" {
          let movie = Movie(movies: dict)
          self.movies.append(movie)
        }
      }
    }
  }

  func downloadImage(withURL url: URL, with completion: @escaping (UIImage) -> ()) {
    let session = URLSession.shared
    let task = session.dataTask(with: url) { (data, response, error) in
      if let imageData = data {
        if let image = UIImage(data: imageData) {
          completion(image)
        }
      }
    }
    task.resume()
  }
}
