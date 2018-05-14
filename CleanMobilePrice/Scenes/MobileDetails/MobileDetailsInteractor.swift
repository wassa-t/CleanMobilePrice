//
//  MobileDetailsInteractor.swift
//  CleanMobilePrice
//
//  Created by SCBUX on 4/5/2561 BE.
//  Copyright (c) 2561 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit

protocol MobileDetailsInteractorInterface {
  func getImages(request: MobileDetails.GetImages.Request)
  func displayDetails(request: MobileDetails.DisplayDetails.Request)
  var mobile: Mobile! { get set }
  var images: [MobileImage]? { get }
}

class MobileDetailsInteractor: MobileDetailsInteractorInterface {
  var presenter: MobileDetailsPresenterInterface!
  var worker: MobileDetailsWorker?
  var mobile: Mobile!
  var images: [MobileImage]?
  
  // MARK: - Business logic
  
  func displayDetails(request:
    MobileDetails.DisplayDetails.Request) {
    guard let mobile = mobile else {
      return
    }
    let response = MobileDetails.DisplayDetails.Response(mobile: mobile)
    presenter.presentDetails(response: response)
  }
  
  func getImages(request: MobileDetails.GetImages.Request) {
    guard let mobile = mobile else {
      return
    }
    worker?.getImages(for: mobile.id!) { [weak self] in
      if case let Result.success(data) = $0 {
        self?.images = data
      }
      
      let response = MobileDetails.GetImages.Response(result: $0)
      self?.presenter.presentImages(response: response)
    }
  }
}
