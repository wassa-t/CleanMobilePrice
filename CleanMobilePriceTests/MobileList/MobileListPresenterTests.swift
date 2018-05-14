//
//  MobileListPresenterTests.swift
//  CleanMobilePrice
//
//  Created by SCBUX on 11/5/2561 BE.
//  Copyright (c) 2561 Teerawat Vanasapdamrong. All rights reserved.
//

@testable import CleanMobilePrice
import XCTest

class MobileListPresenterTests: XCTestCase {

  // MARK: - Subject under test

  var sut: MobileListPresenter!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupMobileListPresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupMobileListPresenter() {
    sut = MobileListPresenter()
  }

  class MobileListPresenterOutputSpy: MobileListViewControllerInterface {
    var displayMobilesIsCalled = false
    
    func displayMobiles(viewModel: MobileList.PresentMobile.ViewModel) {
      displayMobilesIsCalled = true
    }
    
    func displayError() {
      
    }
  }
  
  // MARK: - Tests
  
  func testPresentMobilesShouldAskViewControllerToDisplayMobiles() {
    // Given
    let mobileListViewControllerSpy = MobileListPresenterOutputSpy()
    sut.viewController = mobileListViewControllerSpy
    
    // When
    sut.presentMobiles(response: MobileList.PresentMobile.Response(mobiles: [Seeds.Mobiles.xPhoneX], listType: .favorite))
    
    // Then
    XCTAssert(mobileListViewControllerSpy.displayMobilesIsCalled)
  }
}
