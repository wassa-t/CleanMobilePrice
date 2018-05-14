//
//  MobileDetailsWorker.swift
//  CleanMobilePrice
//
//  Created by SCBUX on 4/5/2561 BE.
//  Copyright (c) 2561 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit

protocol MobileDetailsStoreProtocol {
  func getImages(for mobileID: Int, _ completion: @escaping (Result<[MobileImage]>) -> Void)
}

class MobileDetailsWorker {

  var store: MobileDetailsStoreProtocol

  init(store: MobileDetailsStoreProtocol) {
    self.store = store
  }

  // MARK: - Business Logic

  func getImages(for mobileID: Int, _ completion: @escaping (Result<[MobileImage]>) -> Void) {
    store.getImages(for: mobileID) {
      completion($0)
    }
  }
}
