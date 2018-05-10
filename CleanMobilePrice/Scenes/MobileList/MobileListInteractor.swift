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
  func sortMobiles(request: MobileList.SortMobiles.Request)
  func changeList(request: MobileList.ChangeList.Request)
  func addMobileToFavorite(request: MobileList.AddRemoveFavorite.Request)
  func removeMobileFromFavorite(request: MobileList.AddRemoveFavorite.Request)
  var selectedMobile: Mobile? { get }
}

class MobileListInteractor: MobileListInteractorInterface {
  var presenter: MobileListPresenterInterface!
  var worker: MobileListWorker?
  var mobiles: [Mobile]?
  var selectedMobile: Mobile?
  var sortingType: SortingType?
  var listType: ListType = .all
  var dataManager: DataManagerProtocol! = DataManager.shared
  
  var displayingMobiles: [Mobile]? {
    var displayingMobiles = mobiles
    if let sortingType = sortingType {
      switch sortingType {
      case .priceHighToLow:
        displayingMobiles = displayingMobiles?.sorted(by: { (m1, m2) -> Bool in
          m1.price ?? 0 > m2.price ?? 0
        })
      case .priceLowToHigh:
        displayingMobiles = displayingMobiles?.sorted(by: { (m1, m2) -> Bool in
          m1.price ?? 0 < m2.price ?? 0
        })
      case .rating:
        displayingMobiles = displayingMobiles?.sorted(by: { (m1, m2) -> Bool in
          m1.rating ?? 0 > m2.rating ?? 0
        })
      }
    }
    switch listType {
    case .favorite:
      displayingMobiles = displayingMobiles?.filter({ dataManager.favoriteIDs.contains($0.id!) })
    default:
      break
    }
    return displayingMobiles
  }

  // MARK: - Business logic

  func getMobiles(request: MobileList.GetMobiles.Request) {
    worker?.getMobiles { [weak self] in
      if case let Result.success(data) = $0 {
        self?.mobiles = data
        let response = MobileList.PresentMobile.Response(mobiles: self?.displayingMobiles, listType: self?.listType)
        self?.presenter.presentMobiles(response: response)
      } else {
        self?.presenter.presentError()
      }
    }
  }
  
  func changeList(request: MobileList.ChangeList.Request) {
    listType = request.listType
    let response = MobileList.PresentMobile.Response(mobiles: displayingMobiles, listType: listType)
    presenter.presentMobiles(response: response)
  }
  
  func setSelectedMobile(request: MobileList.SetSelectedMobile.Request) {
    selectedMobile = displayingMobiles?[request.selectedIndex]
  }
  
  func sortMobiles(request: MobileList.SortMobiles.Request) {
    sortingType = request.sortingType
    let response = MobileList.PresentMobile.Response(mobiles: displayingMobiles, listType: listType)
    presenter.presentMobiles(response: response)
  }
  
  func addMobileToFavorite(request: MobileList.AddRemoveFavorite.Request) {
    if let mobileID = displayingMobiles?[request.index].id {
      dataManager.addFavorite(mobileID: mobileID)
    }
  }
  
  func removeMobileFromFavorite(request: MobileList.AddRemoveFavorite.Request) {
    if let mobileID = displayingMobiles?[request.index].id {
      dataManager.removeFavorite(mobileID: mobileID)
    }
  }
}
