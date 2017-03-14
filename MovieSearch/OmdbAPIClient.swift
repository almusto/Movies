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
    let urlString = "\(baseURL)s=\(title)&type=movie"
    let url = URL(string: urlString)
    let session = URLSession.shared

    if let unwrappedURL = url {
      let task = session.dataTask(with: unwrappedURL, completionHandler: { (data, response, error) in
        
        if let unwrappedData = data {

          DispatchQueue.main.async {

            do {
              let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [String:Any]
              let movies = responseJSON["Search"] as! [[String:Any]]
              completion(movies)
            } catch {
              print(error)
            }
          }
        }
      })
      task.resume()
    }
  }


  class func getMovieDetail(withID id: String, completion: @escaping ([String:String]) -> ()) {
    let urlString = "\(baseURL)i=\(id)"
    let url = URL(string: urlString)
    let session = URLSession.shared

    if let unwrappedURL = url {
        let task = session.dataTask(with: unwrappedURL, completionHandler: { (data, response, error) in
          if let unwrappedData = data {
            DispatchQueue.main.async {

              do {
                let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [String:String]
                completion(responseJSON)
              } catch {
                print(error)
              }
            }
          }
        })
      task.resume()
    }
  }

}
