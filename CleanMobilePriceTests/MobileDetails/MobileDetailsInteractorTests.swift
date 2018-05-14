//
//  MobileDetailsInteractorTests.swift
//  CleanMobilePrice
//
//  Created by SCBUX on 14/5/2561 BE.
//  Copyright (c) 2561 Teerawat Vanasapdamrong. All rights reserved.
//

@testable import CleanMobilePrice
import XCTest

class MobileDetailsInteractorTests: XCTestCase {

  // MARK: - Subject under test

  var sut: MobileDetailsInteractor!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupMobileDetailsInteractor()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupMobileDetailsInteractor() {
    sut = MobileDetailsInteractor()
  }

  class MobileDetailsInteractorOutputSpy: MobileDetailsPresenterInterface {
    var presentDetailsIsCalled = false
    var presentImagesIsCalled = false
    
    func presentDetails(response: MobileDetails.DisplayDetails.Response) {
      presentDetailsIsCalled = true
    }
    
    func presentImages(response: MobileDetails.GetImages.Response) {
      presentImagesIsCalled = true
    }
  }
  
  class MobileDetailsWorkerSpy: MobileDetailsWorker {
    var getImagesIsCalled = false
    override func getImages(for mobileID: Int, _ completion: @escaping (Result<[MobileImage]>) -> Void) {
      getImagesIsCalled = true
      completion(Result.success([Seeds.MobileImages.image00, Seeds.MobileImages.image01]))
    }
  }

  // MARK: - Tests

  func testDisplayDetailsShouldAskPresenterToPresentDetails() {
    // Given
    let mobileDetailsPresenterSpy = MobileDetailsInteractorOutputSpy()
    sut.presenter = mobileDetailsPresenterSpy
    sut.mobile = Seeds.Mobiles.xPhoneX
    
    // When
    sut.displayDetails(request: MobileDetails.DisplayDetails.Request())
    
    // Then
    XCTAssert(mobileDetailsPresenterSpy.presentDetailsIsCalled)
  }
  
  func testGetImagesShouldAskWorkerToGetImagesAndPresenterToPresentImages() {
    // Given
    let mobileDetailsPresenterSpy = MobileDetailsInteractorOutputSpy()
    sut.presenter = mobileDetailsPresenterSpy
    sut.mobile = Seeds.Mobiles.xPhoneX
    let mobileDetailsWorkerSpy = MobileDetailsWorkerSpy(store: MobileDetailsStore())
    sut.worker = mobileDetailsWorkerSpy
    
    // When
    sut.getImages(request: MobileDetails.GetImages.Request())
    
    // Then
    XCTAssert(mobileDetailsWorkerSpy.getImagesIsCalled)
    XCTAssert(mobileDetailsPresenterSpy.presentImagesIsCalled)
  }
}
