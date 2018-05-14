//
//  Test.swift
//  CleanMobilePrice
//
//  Created by SCBUX on 14/5/2561 BE.
//  Copyright © 2561 Teerawat Vanasapdamrong. All rights reserved.
//

import Foundation

class TestClass {
  var testVar: String! {
    didSet {
      
    }
  }
  
  var testString: String!
  
  init(testString: String) {
    self.testString = testString
  }
  
  func testFunc() {
    testString.append("hello")
  }
}
