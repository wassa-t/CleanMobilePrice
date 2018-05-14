//
//  MobileDetailsStore.swift
//  CleanMobilePrice
//
//  Created by SCBUX on 4/5/2561 BE.
//  Copyright (c) 2561 Teerawat Vanasapdamrong. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MobileDetailsStore: MobileDetailsStoreProtocol {
  func getImages(for mobileID: Int, _ completion: @escaping (Result<[MobileImage]>) -> Void) {
    Alamofire.request("https://scb-test-mobile.herokuapp.com/api/mobiles/\(mobileID)/images", encoding: JSONEncoding.default)
      .validate()
      .responseJSON { response in
        switch response.result {
        case .success(let value):
          let array = JSON(value)
          var images: [MobileImage] = []
          for json in array.arrayValue {
            let decoder = JSONDecoder()
            if let image = try? decoder.decode(MobileImage.self, from: json.rawData()) {
              images.append(image)
            }
          }
          completion(.success(images))
        case .failure(let error):
          completion(.failure(error))
        }
    }
  }
}
