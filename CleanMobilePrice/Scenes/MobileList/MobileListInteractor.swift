//
//  MobileListInteractor.swift
//  CleanMobilePrice
//
//  Created by Teerawat Vanasapdamrong on 3/5/2561 BE.
//  Copyright (c) 2561 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit

protocol MobileListInteractorInterface {
  func getMobiles(request: MobileList.GetMobiles.Request)
  func setSelectedMobile(request: MobileList.SetSelectedMobile.Request)
  var mobiles: [Mobile]? { get }
  var selectedMobile: Mobile? { get }
}

class MobileListInteractor: MobileListInteractorInterface {
  var presenter: MobileListPresenterInterface!
  var worker: MobileListWorker?
  var mobiles: [Mobile]?
  var selectedMobile: Mobile?

  // MARK: - Business logic

  func getMobiles(request: MobileList.GetMobiles.Request) {
    worker?.getMobiles { [weak self] in
      if case let Result.success(data) = $0 {
        self?.mobiles = data
      }
      
      let response = MobileList.GetMobiles.Response(result: $0)
      self?.presenter.presentMobiles(response: response)
    }
  }
  
  func setSelectedMobile(request: MobileList.SetSelectedMobile.Request) {
    selectedMobile = mobiles?[request.selectedIndex]
  }
}
