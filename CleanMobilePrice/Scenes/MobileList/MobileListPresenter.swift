//
//  MobileListPresenter.swift
//  CleanMobilePrice
//
//  Created by Teerawat Vanasapdamrong on 3/5/2561 BE.
//  Copyright (c) 2561 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit

protocol MobileListPresenterInterface {
  func presentMobiles(response: MobileList.PresentMobile.Response)
  func presentError()
}

class MobileListPresenter: MobileListPresenterInterface {
  weak var viewController: MobileListViewControllerInterface!
  
  // MARK: - Presentation logic
  
  func presentMobiles(response: MobileList.PresentMobile.Response) {
    var displayedMobiles: [Mobile.Displayed] = []
    if let mobiles = response.mobiles {
      for mobile in mobiles {
        let displayedMobile = Mobile.Displayed(
          name: mobile.name,
          description: mobile.description,
          price: mobile.priceString,
          rating: mobile.ratingString,
          thumbImageURL: mobile.thumbImageURL,
          isFavorite: mobile.isFavorite
        )
        displayedMobiles.append(displayedMobile)
      }
    }
    let viewModel = MobileList.PresentMobile.ViewModel(displayedMobiles: displayedMobiles, listType: response.listType!)
    viewController.displayMobiles(viewModel: viewModel)
  }
  
  func presentError() {
    
  }
}
