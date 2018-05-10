//
//  MobileListWorker.swift
//  CleanMobilePrice
//
//  Created by Teerawat Vanasapdamrong on 3/5/2561 BE.
//  Copyright (c) 2561 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit

protocol MobileListStoreProtocol {
  func getMobiles(_ completion: @escaping (Result<[Mobile]>) -> Void)
  func addMobileToFavorite(mobileID: Int)
}

class MobileListWorker {
  
  var store: MobileListStoreProtocol
  
  init(store: MobileListStoreProtocol) {
    self.store = store
  }
  
  // MARK: - Business Logic
  
  func getMobiles(_ completion: @escaping (Result<[Mobile]>) -> Void) {
    store.getMobiles {
      completion($0)
    }
  }
  
  func addMobileToFavorite(mobileID: Int) {
    store.addMobileToFavorite(mobileID: mobileID)
  }
}
