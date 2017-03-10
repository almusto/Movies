//
//  HomeVC.swift
//  MovieSearch
//
//  Created by Alessandro Musto on 3/10/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  @IBOutlet weak var collectionView: UICollectionView!

  let store = MovieDataStore.sharedInstance
  let search = UISearchBar()


    override func viewDidLoad() {
        super.viewDidLoad()


      search.placeholder = "Enter Search Here!"
      search.delegate = self

      self.navigationItem.titleView = search

      collectionView.delegate = self
      collectionView.dataSource = self


    }


  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return store.movies.count
  }


  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieSearchCell
    let movieImageURL = store.movies[indexPath.row].posterURL
    if let posterURL = movieImageURL {
      store.downloadImage(withURL: posterURL) { (image) in
        cell.imageView.image = image
      }
    }

    return cell
    
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.bounds.width/3, height: view.bounds.height/3)
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    if let text = searchBar.text {
      guard let searchString = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
      store.getMovies(withTitle: searchString) {}
    }

    collectionView.reloadData()
  }










    
}
