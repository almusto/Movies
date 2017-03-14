//
//  MovieDetailVC.swift
//  MovieSearch
//
//  Created by Alessandro Musto on 3/10/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import UIKit

class MovieDetailVC: UIViewController {

  @IBOutlet weak var viewForImage: UIView!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var textView: UITextView!
  
  @IBOutlet weak var releasedLabel: UILabel!
  @IBOutlet weak var directorLabel: UILabel!
  @IBOutlet weak var writerLabel: UILabel!
  @IBOutlet weak var starsLabel: UILabel!
  @IBOutlet weak var imdbScoreLabel: UILabel!
  @IBOutlet weak var metascoreLabel: UILabel!

  var movie: Movie!
  var favMovie: FavMovie!
  var posterURL: URL?
  var imdbID: String!
  let store = MovieDataStore.sharedInstance
  var movieDetail: MovieDetail!
  var blurrImage: UIImage!
  let coreData = CoreDataStack.store

    override func viewDidLoad() {
        super.viewDidLoad()


      self.navigationController?.navigationBar.barTintColor = UIColor.gray
      self.tabBarController?.tabBar.barTintColor = UIColor.gray

      if movie != nil {
        posterURL = movie.posterURL
        navigationItem.title = movie.title
        imdbID = movie.imdbID
      } else {
        if let url = URL(string: favMovie.posterURL!){
          posterURL = url

        }
        navigationItem.title = favMovie.title
        imdbID = favMovie.imdbID
      }


      store.getMovieDetail(withID: imdbID) {

        self.movieDetail = self.store.movieDetail
        self.textView.text = self.movieDetail.shortPlot
        self.releasedLabel.text = "RELEASED: \(self.movieDetail.yearReleased)"
        self.directorLabel.text = "DIRECTOR: \(self.movieDetail.director)"
        self.writerLabel.text = "WRITER: \(self.movieDetail.writer)"
        self.starsLabel.text = "STARS: \(self.movieDetail.actors)"
        self.imdbScoreLabel.text = "IMDB Score: \(self.movieDetail.imdbScore)"
        self.metascoreLabel.text = "Metascore: \(self.movieDetail.metaScore)"

      }



      if let posterURL = posterURL {
        store.downloadImage(withURL: posterURL) { (image) in
          DispatchQueue.main.async {
            self.imageView.image = image
            self.blurrImage = image
            let blurView = UIImageView(image: self.blurrImage)
            blurView.contentMode = .scaleToFill
            blurView.frame = self.viewForImage.bounds

            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)

            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.viewForImage.bounds

            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurView.addSubview(blurEffectView)


            self.viewForImage.insertSubview(blurView, belowSubview: self.imageView)
          }
        }

      }

  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "goToPlot" {
      let dest = segue.destination as! PlotVC
      dest.movieDetail = movieDetail
    }
  }

  @IBAction func onFav(_ sender: UIBarButtonItem) {
    coreData.storeNote(withTitle: movie.title, imdbID: movie.imdbID, posterURL: movieDetail.posterURL)

  }


}
