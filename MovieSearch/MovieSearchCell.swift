//
//  MovieSearchCell.swift
//  MovieSearch
//
//  Created by Alessandro Musto on 3/10/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import UIKit

class MovieSearchCell: UICollectionViewCell {

      @IBOutlet weak var imageView: UIImageView!

      fileprivate let store = MovieDataStore.sharedInstance

      var movie: Movie! {
        didSet {
            if let url = movie.posterURL {
                store.downloadImage(withURL: url, with: { (image) in
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                })
            }
        }
    }
}
