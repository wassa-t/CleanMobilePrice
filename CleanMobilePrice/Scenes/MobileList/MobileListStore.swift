//
//  MobileListStore.swift
//  CleanMobilePrice
//
//  Created by Teerawat Vanasapdamrong on 3/5/2561 BE.
//  Copyright (c) 2561 Teerawat Vanasapdamrong. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MobileListStore: MobileListStoreProtocol {
  func getMobiles(_ completion: @escaping (Result<[Mobile]>) -> Void) {
    Alamofire.request("https://scb-test-mobile.herokuapp.com/api/mobiles/", encoding: JSONEncoding.default)
      .validate()
      .responseJSON { response in
        switch response.result {
        case .success(let value):
          let array = JSON(value)
          var mobiles: [Mobile] = []
          for json in array.arrayValue {
            let decoder = JSONDecoder()
            if let mobile = try? decoder.decode(Mobile.self, from: json.rawData()) {
              mobiles.append(mobile)
            }
          }
          completion(.success(mobiles))
        case .failure(let error):
          completion(.failure(error))
        }
    }
  }
  
  func addMobileToFavorite(mobileID: Int) {
    
  }
}
