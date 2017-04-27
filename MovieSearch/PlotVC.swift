//
//  PlotVC.swift
//  MovieSearch
//
//  Created by Alessandro Musto on 3/10/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import UIKit

class PlotVC: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var movieDetail: MovieDetail!

    override func viewDidLoad() {
        super.viewDidLoad()
          self.navigationController?.navigationBar.barTintColor = UIColor.gray
          self.tabBarController?.tabBar.barTintColor = UIColor.gray
          textView.text = movieDetail.shortPlot
    }

}
