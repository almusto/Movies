//
//  FavMovieCell.swift
//  MovieSearch
//
//  Created by Alessandro Musto on 3/10/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import UIKit

class FavMovieCell: UITableViewCell {

  let store = MovieDataStore.sharedInstance
  var posterImageView: UIImageView!
  var titleLabel: UILabel!
  var favMovie: FavMovie! {
    didSet {
      if let url = URL(string: favMovie.posterURL!) {
        store.downloadImage(withURL: url, with: { (image) in
          self.posterImageView.image = image
        })
      }
      titleLabel.text = favMovie.title
    }
  }



  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }


  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()

  }

  func commonInit() {

    posterImageView = UIImageView()
    posterImageView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(posterImageView)
    posterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10) .isActive = true
    posterImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    posterImageView.heightAnchor.constraint(equalToConstant: 75).isActive = true
    posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 72/112).isActive = true

    titleLabel = UILabel()
    contentView.addSubview(titleLabel)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 10).isActive = true
    titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true


  }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }




}
