//
//  MobileListTableViewCell.swift
//  CleanMobilePrice
//
//  Created by SCBUX on 3/5/2561 BE.
//  Copyright © 2561 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit
import SDWebImage

class MobileListTableViewCell: UITableViewCell {
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var descriptionLabel: UILabel!
  @IBOutlet var priceLabel: UILabel!
  @IBOutlet var ratingLabel: UILabel!
  @IBOutlet var favouriteButton: UIButton!
  @IBOutlet var thumbnailView: UIImageView!
  
  func displayCell(displayedMobile: Mobile.Displayed) {
    nameLabel.text = displayedMobile.name
    descriptionLabel.text = displayedMobile.description
    priceLabel.text = displayedMobile.price
    ratingLabel.text = displayedMobile.rating
    thumbnailView.sd_setImage(with: displayedMobile.thumbImageURL)
  }
}
