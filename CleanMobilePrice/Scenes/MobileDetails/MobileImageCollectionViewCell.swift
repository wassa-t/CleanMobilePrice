//
//  MobileImageCollectionViewCell.swift
//  CleanMobilePrice
//
//  Created by SCBUX on 10/5/2561 BE.
//  Copyright © 2561 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit

class MobileImageCollectionViewCell: UICollectionViewCell {
  @IBOutlet var imageView: UIImageView!
  
  func displayCell(imageURL: URL) {
    imageView.sd_setImage(with: imageURL)
  }
}
