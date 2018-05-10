//
//  MobileListTableViewCell.swift
//  CleanMobilePrice
//
//  Created by SCBUX on 3/5/2561 BE.
//  Copyright © 2561 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit
import SDWebImage

protocol MobileListTableViewCellDelegate: class {
  func addMobileToFavorite(at index: Int)
  func removeMobileFromFavorite(at index: Int)
}

class MobileListTableViewCell: UITableViewCell {
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var descriptionLabel: UILabel!
  @IBOutlet var priceLabel: UILabel!
  @IBOutlet var ratingLabel: UILabel!
  @IBOutlet var favoriteButton: UIButton!
  @IBOutlet var thumbnailView: UIImageView!
  
  var index: Int?
  weak var delegate: MobileListTableViewCellDelegate?
  
  func displayCell(displayedMobile: Mobile.Displayed) {
    nameLabel.text = displayedMobile.name
    descriptionLabel.text = displayedMobile.description
    priceLabel.text = displayedMobile.price
    ratingLabel.text = displayedMobile.rating
    favoriteButton.isSelected = displayedMobile.isFavorite
    thumbnailView.sd_setImage(with: displayedMobile.thumbImageURL)
  }
  
  @IBAction func addToFavorite(sender: UIButton) {
    if let index = index {
      sender.isSelected = !sender.isSelected
      if sender.isSelected {
        delegate?.addMobileToFavorite(at: index)
      } else {
        delegate?.removeMobileFromFavorite(at: index)
      }
    }
  }
}
