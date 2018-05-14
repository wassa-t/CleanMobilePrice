//
//  MobileListModels.swift
//  CleanMobilePrice
//
//  Created by Teerawat Vanasapdamrong on 3/5/2561 BE.
//  Copyright (c) 2561 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit

enum SortingType {
  case priceHighToLow
  case priceLowToHigh
  case rating
}

enum ListType {
  case all
  case favorite
}

struct MobileList {
  struct GetMobiles {
    struct Request {
    }
    struct Response {
    }
    struct ViewModel {
    }
  }
  
  struct PresentMobile {
    struct Request {
      var listType: ListType
    }
    struct Response {
      var mobiles: [Mobile]?
      var listType: ListType? = .all
    }
    struct ViewModel {
      var displayedMobiles: [Mobile.Displayed]?
      var listType: ListType
    }
  }
  
  struct AddRemoveFavorite {
    struct Request {
      var index: Int
    }
    struct Response {
    }
    struct ViewModel {
    }
  }
  
  struct ChangeList {
    struct Request {
      var listType: ListType
    }
    struct Response {
    }
    struct ViewModel {
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
  
  struct SortMobiles {
    struct Request {
      var sortingType: SortingType
    }
    struct Response {
    }
    struct ViewModel {
    }
  }
}
