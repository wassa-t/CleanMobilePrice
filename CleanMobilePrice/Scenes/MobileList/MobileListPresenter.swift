//
//  MobileListPresenter.swift
//  CleanMobilePrice
//
//  Created by Teerawat Vanasapdamrong on 3/5/2561 BE.
//  Copyright (c) 2561 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit

protocol MobileListPresenterInterface {
  func presentMobiles(response: MobileList.GetMobiles.Response)
}

class MobileListPresenter: MobileListPresenterInterface {
  weak var viewController: MobileListViewControllerInterface!
  
  // MARK: - Presentation logic
  
  func presentMobiles(response: MobileList.GetMobiles.Response) {
    switch response.result {
    case .success(let mobiles):
      var displayedMobiles: [Mobile.Displayed] = []
      for mobile in mobiles {
        let displayedMobile = Mobile.Displayed(
          name: mobile.name,
          description: mobile.description,
          price: mobile.priceString,
          rating: mobile.ratingString,
          thumbImageURL: mobile.thumbImageURL
        )
        displayedMobiles.append(displayedMobile)
      }
      let viewModel = MobileList.GetMobiles.ViewModel(displayedMobiles: displayedMobiles)
      viewController.displayMobiles(viewModel: viewModel)
    case .failure:
      viewController.displayError()
    }
  }
}
