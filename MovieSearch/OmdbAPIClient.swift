//
//  OmdbAPIClient.swift
//  MovieSearch
//
//  Created by Alessandro Musto on 3/10/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import Foundation

final class OmbdAPIClient {

    static func getSearchResults(withTitle title: String, completion: @escaping ([[String:Any]]?, Error?) -> ()) {
        let urlString = "\(baseURL)s=\(title)&type=movie"
        let url = URL(string: urlString)
        let session = URLSession.shared

        if let unwrappedURL = url {
            let task = session.dataTask(with: unwrappedURL, completionHandler: { (data, response, error) in
                if let unwrappedData = data {
                    let responseJSON = try? JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [String:Any]
                    let movies = responseJSON?["Search"] as! [[String:Any]]
                    completion(movies, nil)
                } else {
                    completion(nil, error)
                }
            })
            task.resume()
        }
    }


    static func getMovieDetail(withID id: String, completion: @escaping ([String:Any]?, Error?) -> ()) {
        let urlString = "\(baseURL)i=\(id)"
        let url = URL(string: urlString)
        let session = URLSession.shared

        if let unwrappedURL = url {
            let task = session.dataTask(with: unwrappedURL, completionHandler: { (data, response, error) in
                if let unwrappedData = data {
                        let responseJSON = try? JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [String:Any]
                        completion(responseJSON, nil)
                } else {
                    completion(nil, error)
                }
            })
            task.resume()
        }
      }
}
