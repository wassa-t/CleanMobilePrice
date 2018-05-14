//
//  MobileDetailsPresenterTests.swift
//  CleanMobilePrice
//
//  Created by SCBUX on 14/5/2561 BE.
//  Copyright (c) 2561 Teerawat Vanasapdamrong. All rights reserved.
//

@testable import CleanMobilePrice
import XCTest

class MobileDetailsPresenterTests: XCTestCase {

  // MARK: - Subject under test

  var sut: MobileDetailsPresenter!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupMobileDetailsPresenter()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupMobileDetailsPresenter() {
    sut = MobileDetailsPresenter()
  }

  class MobileDetailsPresenterOutputSpy: MobileDetailsViewControllerInterface {
    var displayDetailsIsCalled = false
    var displayImagesIsCalled = false
    
    func displayDetails(viewModel: MobileDetails.DisplayDetails.ViewModel) {
      displayDetailsIsCalled = true
    }
    
    func displayImages(viewModel: MobileDetails.GetImages.ViewModel) {
      displayImagesIsCalled = true
    }
    
    func displayError() {
      
    }
  }

  // MARK: - Tests
  
  func testPresentDetailsShouldAskViewControllerToDisplayDetails() {
    // Given
    let mobileDetailsViewControllerSpy = MobileDetailsPresenterOutputSpy()
    sut.viewController = mobileDetailsViewControllerSpy
    
    // When
    sut.presentDetails(response: MobileDetails.DisplayDetails.Response(mobile: Seeds.Mobiles.xPhoneX))
    
    // Then
    XCTAssert(mobileDetailsViewControllerSpy.displayDetailsIsCalled)
  }
  
  func testPresentImagesShouldAskViewControllerToDisplayImages() {
    // Given
    let mobileDetailsViewControllerSpy = MobileDetailsPresenterOutputSpy()
    sut.viewController = mobileDetailsViewControllerSpy
    
    // When
    sut.presentImages(response: MobileDetails.GetImages.Response(result: Result.success([Seeds.MobileImages.image00, Seeds.MobileImages.image01])))
    
    // Then
    XCTAssert(mobileDetailsViewControllerSpy.displayImagesIsCalled)
  }
}
