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
    // NOTE: Format the response from the Interactor and pass the result back to the View Controller. The resulting view model should be using only primitive types. Eg: the view should not need to involve converting date object into a formatted string. The formatting is done here.
    
    switch response.result {
    case .success(let mobiles):
      let viewModel = MobileList.GetMobiles.ViewModel()
      viewController.displayMobiles(viewModel: viewModel)
    case .failure(let error):
      viewController.displayError()
    }
  }
}
