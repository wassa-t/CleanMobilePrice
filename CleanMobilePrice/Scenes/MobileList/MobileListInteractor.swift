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
  var model: [Mobile]? { get }
}

class MobileListInteractor: MobileListInteractorInterface {
  var presenter: MobileListPresenterInterface!
  var worker: MobileListWorker?
  var model: [Mobile]?

  // MARK: - Business logic

  func getMobiles(request: MobileList.GetMobiles.Request) {
    worker?.getMobiles { [weak self] in
      if case let Result.success(data) = $0 {
        // If the result was successful, we keep the data so that we can deliver it to another view controller through the router.
        self?.model = data
      }

      // NOTE: Pass the result to the Presenter. This is done by creating a response model with the result from the worker. The response could contain a type like UserResult enum (as declared in the SCB Easy project) with the result as an associated value.
      let response = MobileList.GetMobiles.Response(result: $0)
      self?.presenter.presentMobiles(response: response)
    }
  }
}
