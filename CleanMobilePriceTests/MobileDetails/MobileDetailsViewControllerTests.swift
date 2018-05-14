//
//  MobileDetailsViewControllerTests.swift
//  CleanMobilePrice
//
//  Created by SCBUX on 14/5/2561 BE.
//  Copyright (c) 2561 Teerawat Vanasapdamrong. All rights reserved.
//

@testable import CleanMobilePrice
import XCTest

class MobileDetailsViewControllerTests: XCTestCase {

  // MARK: - Subject under test

  var sut: MobileDetailsViewController!
  var window: UIWindow!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    window = UIWindow()
    setupMobileDetailsViewController()
  }

  override func tearDown() {
    window = nil
    super.tearDown()
  }

  // MARK: - Test setup

  func setupMobileDetailsViewController() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    sut = storyboard.instantiateViewController(withIdentifier: "MobileDetailsViewController") as! MobileDetailsViewController
    window.addSubview(sut.view)
  }

  class MobileDetailsViewControllerOutputSpy: MobileDetailsInteractorInterface {
    var getImagesIsCalled = false
    var displayDetailsIsCalled = false
    var mobile: Mobile!
    var images: [MobileImage]?
    
    func getImages(request: MobileDetails.GetImages.Request) {
      getImagesIsCalled = true
    }
    
    func displayDetails(request: MobileDetails.DisplayDetails.Request) {
      displayDetailsIsCalled = true
    }
  }

  // MARK: - Tests

  func testDisplayDetailsOnLoadShouldAskInteractorToDisplayDetails() {
    // Given
    let mobileDetailsInteractorSpy = MobileDetailsViewControllerOutputSpy()
    mobileDetailsInteractorSpy.mobile = Seeds.Mobiles.xPhoneX
    sut.interactor = mobileDetailsInteractorSpy

    // When
    sut.displayDetailsOnLoad()

    // Then
    XCTAssert(mobileDetailsInteractorSpy.displayDetailsIsCalled)
  }
  
  func testGetImagesOnLoadShouldAskInteractorToGetImages() {
    // Given
    let mobileDetailsInteractorSpy = MobileDetailsViewControllerOutputSpy()
    mobileDetailsInteractorSpy.mobile = Seeds.Mobiles.xPhoneX
    sut.interactor = mobileDetailsInteractorSpy
    
    // When
    sut.getImagesOnLoad()
    
    // Then
    XCTAssert(mobileDetailsInteractorSpy.getImagesIsCalled)
  }
  
  func testDisplayDetailsShouldDisplayCorrectDetails() {
    // Given
    let viewModel = MobileDetails.DisplayDetails.ViewModel(displayedMobile: Mobile.Displayed(name: "test name", description: "test description", price: "test price", rating: "test rating", thumbImageURL: URL(string: "www.google.com"), isFavorite: true))
    
    // When
    sut.displayDetails(viewModel: viewModel)
    
    // Then
    XCTAssertEqual(sut.title, "test name")
    XCTAssertEqual(sut.descriptionTextView.text, "test description")
    XCTAssertEqual(sut.priceLabel.text, "test price")
    XCTAssertEqual(sut.ratingLabel.text, "test rating")
  }
}
