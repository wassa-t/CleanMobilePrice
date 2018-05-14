//
//  DataManager.swift
//  CleanMobilePrice
//
//  Created by SCBUX on 10/5/2561 BE.
//  Copyright © 2561 Teerawat Vanasapdamrong. All rights reserved.
//

import Foundation

protocol DataManagerProtocol {
  func addFavorite(mobileID: Int)
  func removeFavorite(mobileID: Int)
  var favoriteIDs: Set<Int>! { get }
}

class DataManager: DataManagerProtocol {
  static let shared: DataManager = DataManager()
  var favoriteIDs: Set<Int>! = []
  
  init() {
    getFavorites()
  }
  
  private func getFavorites() {
    if let data = UserDefaults.standard.object(forKey: "favorites") as? Data {
      favoriteIDs = NSKeyedUnarchiver.unarchiveObject(with: data) as! Set<Int>
    }
  }
  
  func addFavorite(mobileID: Int) {
    favoriteIDs.insert(mobileID)
    saveData()
  }
  
  func removeFavorite(mobileID: Int) {
    favoriteIDs.remove(mobileID)
    saveData()
  }
  
  private func saveData() {
    let data = NSKeyedArchiver.archivedData(withRootObject: favoriteIDs)
    UserDefaults.standard.set(data, forKey: "favorites")
    UserDefaults.standard.synchronize()
  }
}
