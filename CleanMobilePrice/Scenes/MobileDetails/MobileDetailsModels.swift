//
//  MobileDetailsModels.swift
//  CleanMobilePrice
//
//  Created by SCBUX on 4/5/2561 BE.
//  Copyright (c) 2561 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit

struct MobileDetails {
  struct GetImages {
    /// Data struct sent to Interactor
    struct Request {}
    /// Data struct sent to Presenter
    struct Response {
      var result: Result<[MobileImage]>
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      var imageURLs: [URL]?
    }
  }
  
  struct DisplayDetails {
    struct Request {}
    struct Response {
      var mobile: Mobile
    }
    struct ViewModel {
      var displayedMobile: Mobile.Displayed
    }
  }
}
