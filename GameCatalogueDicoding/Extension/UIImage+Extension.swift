//
//  UIImage+Extension.swift
//  GameCatalogueDicoding
//
//  Created by Kalfian on 11/08/20.
//  Copyright © 2020 Kalfian. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    public func loadImage(url: String) {
        let url = URL(string: url)
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
        
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: Constant.Image.PLACE_HOLDER),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.5)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
