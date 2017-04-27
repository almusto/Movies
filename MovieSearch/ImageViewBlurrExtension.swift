//
//  ImageViewBlurrExtension.swift
//  MovieSearch
//
//  Created by Alessandro Musto on 4/27/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import UIKit


extension UIImageView {
    
    func addBlurr(toView view: UIView, withImage image: UIImage) {

        self.image = image
        let blurrImage = image
        let blurView = UIImageView(image: blurrImage)
        blurView.contentMode = .scaleToFill
        blurView.frame = view.bounds

        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)

        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.addSubview(blurEffectView)

        view.insertSubview(blurView, belowSubview: self)

    }
}
