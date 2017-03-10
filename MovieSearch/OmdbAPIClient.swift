//
//  OmdbAPIClient.swift
//  MovieSearch
//
//  Created by Alessandro Musto on 3/10/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import Foundation

class OmbdAPIClient {



  class func getSearchResults(withTitle title: String, completion: @escaping ([[String:Any]]) -> ()) {
    let urlString = "\(baseURL)\(title)"
    let url = URL(string: urlString)
    let session = URLSession.shared

    if let unwrappedURL = url {
      let task = session.dataTask(with: unwrappedURL, completionHandler: { (data, response, error) in
        if let unwrappedData = data {
          do {
            let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [String:Any]
            let movies = responseJSON["Search"] as! [[String:Any]]
            completion(movies)
          } catch {
            print(error)
          }
        }
      })
      task.resume()
    }
  }

}
