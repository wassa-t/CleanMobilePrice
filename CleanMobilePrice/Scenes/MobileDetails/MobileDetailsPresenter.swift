//
//  MobileDetailsPresenter.swift
//  CleanMobilePrice
//
//  Created by SCBUX on 4/5/2561 BE.
//  Copyright (c) 2561 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit

protocol MobileDetailsPresenterInterface {
  func presentDetails(response: MobileDetails.DisplayDetails.Response)
  func presentImages(response: MobileDetails.GetImages.Response)
}

class MobileDetailsPresenter: MobileDetailsPresenterInterface {
  weak var viewController: MobileDetailsViewControllerInterface!
  var dataManager: DataManagerProtocol = DataManager.shared

  // MARK: - Presentation logic

  func presentDetails(response: MobileDetails.DisplayDetails.Response) {
    let mobile = response.mobile
    let displayedMobile = Mobile.Displayed(
      name: mobile.name,
      description: mobile.description,
      price: mobile.priceString,
      rating: mobile.ratingString,
      thumbImageURL: mobile.thumbImageURL,
      isFavorite: mobile.id != nil ? dataManager.favoriteIDs.contains(mobile.id!) : false
    )
    let viewModel = MobileDetails.DisplayDetails.ViewModel(displayedMobile: displayedMobile)
    viewController.displayDetails(viewModel: viewModel)
  }
  
  func presentImages(response: MobileDetails.GetImages.Response) {
    switch response.result {
    case .success(let images):
      let imageURLs = images.flatMap({ $0.imageURL })
      let viewModel = MobileDetails.GetImages.ViewModel(imageURLs: imageURLs)
      viewController.displayImages(viewModel: viewModel)
    case .failure:
      viewController.displayError()
    }
  }
}
