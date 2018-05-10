//
//  MobileListModels.swift
//  CleanMobilePrice
//
//  Created by Teerawat Vanasapdamrong on 3/5/2561 BE.
//  Copyright (c) 2561 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit

struct MobileList {
  /// This structure represents a use case
  struct GetMobiles {
    /// Data struct sent to Interactor
    struct Request {}
    /// Data struct sent to Presenter
    struct Response {
      var result: Result<[Mobile]>
    }
    /// Data struct sent to ViewController
    struct ViewModel {
      var displayedMobiles: [Mobile.Displayed]?
    }
  }
  
  struct SetSelectedMobile {
    struct Request {
      var selectedIndex: Int
    }
    struct Response {
    }
    struct ViewModel {
    }
  }
}
