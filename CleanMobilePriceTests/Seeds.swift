//
//  Seeds.swift
//  CleanMobilePriceTests
//
//  Created by SCBUX on 11/5/2561 BE.
//  Copyright © 2561 Teerawat Vanasapdamrong. All rights reserved.
//

@testable import CleanMobilePrice
import XCTest

struct Seeds {
  struct Mobiles {
    static let xPhone2 = Mobile(name: "xPhone 2", price: 99.99, thumbImage: "", id: 0, brand: "xPhone", rating: 3.8, description: "xPhone 2 description")
    static let xPhone3G = Mobile(name: "xPhone 3G", price: 199.99, thumbImage: "", id: 1, brand: "xPhone", rating: 3.5, description: "xPhone 3G description")
    static let xPhone5c = Mobile(name: "xPhone 5c", price: 299.99, thumbImage: "", id: 2, brand: "xPhone", rating: 4.5, description: "xPhone 5c description")
    static let xPhone8s = Mobile(name: "xPhone 8s", price: 399.99, thumbImage: "", id: 3, brand: "xPhone", rating: 4, description: "xPhone 8s description")
    static let xPhoneX = Mobile(name: "xPhone X", price: 499.99, thumbImage: "", id: 4, brand: "xPhone", rating: 4.9, description: "xPhone X description")
  }
  
  struct MobileImages {
    static let image00 = MobileImage(mobileID: 0, imagePath: "http://google.com", id: 0)
    static let image01 = MobileImage(mobileID: 0, imagePath: "http://google.com", id: 1)
    static let image10 = MobileImage(mobileID: 1, imagePath: "http://google.com", id: 2)
    static let image11 = MobileImage(mobileID: 1, imagePath: "http://google.com", id: 3)
    static let image12 = MobileImage(mobileID: 1, imagePath: "http://google.com", id: 4)
    static let image20 = MobileImage(mobileID: 2, imagePath: "http://google.com", id: 5)
    static let image30 = MobileImage(mobileID: 3, imagePath: "http://google.com", id: 6)
    static let image40 = MobileImage(mobileID: 4, imagePath: "http://google.com", id: 7)
    static let image41 = MobileImage(mobileID: 4, imagePath: "http://google.com", id: 8)
  }
}
