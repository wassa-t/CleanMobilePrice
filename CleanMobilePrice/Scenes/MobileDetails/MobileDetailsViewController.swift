//
//  MobileDetailsViewController.swift
//  CleanMobilePrice
//
//  Created by SCBUX on 4/5/2561 BE.
//  Copyright (c) 2561 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit

protocol MobileDetailsViewControllerInterface: class {
  func displayDetails(viewModel: MobileDetails.DisplayDetails.ViewModel)
  func displayImages(viewModel: MobileDetails.GetImages.ViewModel)
  func displayError()
}

class MobileDetailsViewController: UIViewController, MobileDetailsViewControllerInterface {
  var interactor: MobileDetailsInteractorInterface!
  var router: MobileDetailsRouter!
  var viewModel: MobileDetails.GetImages.ViewModel!
  
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var descriptionTextView: UITextView!
  @IBOutlet var priceLabel: UILabel!
  @IBOutlet var ratingLabel: UILabel!
  
  // MARK: - Object lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    MobileDetailsConfigurator.sharedInstance.configure(viewController: self)
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    displayDetailsOnLoad()
    getImagesOnLoad()
  }
  
  // MARK: - Event handling
  
  func displayDetailsOnLoad() {
    let request = MobileDetails.DisplayDetails.Request()
    interactor.displayDetails(request: request)
  }
  
  func getImagesOnLoad() {
    let request = MobileDetails.GetImages.Request()
    interactor.getImages(request: request)
  }
  
  // MARK: - Display logic
  
  func displayDetails(viewModel: MobileDetails.DisplayDetails.ViewModel) {
    title = viewModel.displayedMobile.name
    descriptionTextView.text = viewModel.displayedMobile.description
    priceLabel.text = viewModel.displayedMobile.price
    ratingLabel.text = viewModel.displayedMobile.rating
  }
  
  func displayImages(viewModel: MobileDetails.GetImages.ViewModel) {
    self.viewModel = viewModel
    collectionView.reloadData()
  }
  
  func displayError() {
    
  }
}

extension MobileDetailsViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel?.imageURLs?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? MobileImageCollectionViewCell {
      if let imageURL = viewModel.imageURLs?[indexPath.row] {
        cell.displayCell(imageURL: imageURL)
      }
      return cell
    }
    return UICollectionViewCell()
  }
}

extension MobileDetailsViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.collectionView.frame.size.height, height: self.collectionView.frame.size.height)
  }
}
