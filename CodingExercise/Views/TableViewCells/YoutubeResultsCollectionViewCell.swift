//
//  YoutubeResultsCollectionViewCell.swift
//  CodingExercise
//
//  Created by Suslov Babu on 28/09/17.
//  Copyright © 2017 Suslov Babu. All rights reserved.
//

import UIKit

class YoutubeResultsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setupCell(_ item: YoutubeSearchItem?) {
        if item?.thumbnailUrl != nil {
            self.thumbnailImageView.kf.setImage(with: item?.thumbnailUrl)
            
        } else {
            self.thumbnailImageView.image = UIImage(color: UIColor.white)
        }
        
        // setting corners for image view
        self.thumbnailImageView.layer.cornerRadius = 24
        self.thumbnailImageView.layer.masksToBounds = true
        
        self.titleLabel.text = item?.title
        self.channelTitleLabel.text = item?.channelTitle
        self.descriptionLabel.text = item?.videoDescription
        
    }


}
