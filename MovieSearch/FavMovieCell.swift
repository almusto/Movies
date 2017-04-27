//
//  FavMovieCell.swift
//  MovieSearch
//
//  Created by Alessandro Musto on 3/10/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import UIKit

class FavMovieCell: UITableViewCell {

    fileprivate let store = MovieDataStore.sharedInstance
    var posterImageView: UIImageView!
    var titleLabel: UILabel!
    var favMovie: FavMovie! {
        didSet {
            titleLabel.text = favMovie.title

            if let url = URL(string: favMovie.posterURL!) {
                store.downloadImage(withURL: url, with: { (image) in
                    DispatchQueue.main.async {
                        self.posterImageView.image = image
                    }
                })
            }
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
        setConstraints()
    }


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setConstraints()
    }

    func commonInit() {

        posterImageView = UIImageView()
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(posterImageView)

        titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    func setConstraints() {

        posterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10) .isActive = true
        posterImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 72/112).isActive = true

        titleLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 10).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
