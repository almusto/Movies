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

  fileprivate let sectionInsets = UIEdgeInsets(top: 25.0, left: 25.0, bottom: 25.0, right: 25.0)
  fileprivate let itemsPerRow: CGFloat = 2
  fileprivate let aspectRatio: (w: CGFloat, h: CGFloat) = (300, 450)
  var originalContentOffset: CGPoint!

  let store = MovieDataStore.sharedInstance
  let search = UISearchBar()
  var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()


      let imageView = UIImageView(image: UIImage(named: "toy"))
      let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
      let blurEffectView = UIVisualEffectView(effect: blurEffect)
      blurEffectView.frame = view.bounds
      blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      imageView.addSubview(blurEffectView)

      search.placeholder = "Enter Search Here!"
      search.delegate = self

      self.navigationItem.titleView = search

      collectionView.delegate = self
      collectionView.dataSource = self
      collectionView.backgroundView = imageView
      let layout = UICollectionViewFlowLayout()
      let width = UIScreen.main.bounds.width
      layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
      layout.itemSize = CGSize(width: width / 2, height: width / 2)
      layout.minimumInteritemSpacing = 10
      layout.minimumLineSpacing = 10
      collectionView.collectionViewLayout = layout

  }

  //MARK: CollectionView

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }


  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }


  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieSearchCell
    let movieImageURL = movies[indexPath.row].posterURL
    if let posterURL = movieImageURL {
      store.downloadImage(withURL: posterURL) { (image) in
        cell.imageView.image = image
      }
    }

    return cell
    
  }

  //MARK: CollectionViewFlowLayout


  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let width = availableWidth / itemsPerRow
    let multiplyValue: CGFloat = 1.0 + ((aspectRatio.h - aspectRatio.w) / aspectRatio.w)
    let height = width * multiplyValue
    return CGSize(width: width, height: height)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets

  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }


  //MARK: GetData

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    if let text = searchBar.text {
      guard let searchString = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
      self.getMovies(withTitle: searchString)
    }
  }

  func getMovies(withTitle title: String) {

    store.getMovies(withTitle: title) {
      self.collectionView.reloadData()

    }
  }



}
