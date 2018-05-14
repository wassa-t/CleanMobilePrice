//
//  MobileListRouter.swift
//  CleanMobilePrice
//
//  Created by Teerawat Vanasapdamrong on 3/5/2561 BE.
//  Copyright (c) 2561 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit

protocol MobileListRouterInput {
  func navigateToDetails()
}

class MobileListRouter: MobileListRouterInput {
  weak var viewController: MobileListViewController!
  
  // MARK: - Navigation
  
  func navigateToDetails() {
    viewController.performSegue(withIdentifier: "ShowDetailsScene", sender: nil)
  }
  
  // MARK: - Communication
  
  func passDataToNextScene(segue: UIStoryboardSegue) {
    if segue.identifier == "ShowDetailsScene" {
      passDataToDetailsScene(segue: segue)
    }
  }
  
  func passDataToDetailsScene(segue: UIStoryboardSegue) {
    if let detailsVC = segue.destination as? MobileDetailsViewController {
      detailsVC.interactor.mobile = viewController.interactor.selectedMobile
    }
  }
}
