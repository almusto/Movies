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

        self.navigationController?.navigationBar.barTintColor = UIColor.gray
        self.tabBarController?.tabBar.barTintColor = UIColor.gray

        let backgroundImage = #imageLiteral(resourceName: "toy")
        let backgroundImageView = UIImageView()

        backgroundImageView.addBlurr(toView: view, withImage: backgroundImage)

        search.placeholder = "Enter Search Here!"
        search.delegate = self
        navigationItem.titleView = search

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundView = backgroundImageView

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
        cell.movie = movies[indexPath.row]
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
            DispatchQueue.main.async {
                self.movies = self.store.movies
                self.collectionView.reloadData()
            }
        }
    }

    //Mark:- Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "getToDetail" {
            let dest = segue.destination as! MovieDetailVC
            if let indexPath = self.collectionView.indexPathsForSelectedItems {
                let movie = movies[indexPath[0].row]
                dest.movie = movie
            }
        }
    }

}
