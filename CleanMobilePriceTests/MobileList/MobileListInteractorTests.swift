//
//  MobileListInteractorTests.swift
//  CleanMobilePrice
//
//  Created by SCBUX on 11/5/2561 BE.
//  Copyright (c) 2561 Teerawat Vanasapdamrong. All rights reserved.
//

@testable import CleanMobilePrice
import XCTest

class MobileListInteractorTests: XCTestCase {

  // MARK: - Subject under test

  var sut: MobileListInteractor!

  // MARK: - Test lifecycle

  override func setUp() {
    super.setUp()
    setupMobileListInteractor()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Test setup

  func setupMobileListInteractor() {
    sut = MobileListInteractor()
  }

  class MobileListInteractorOutputSpy: MobileListPresenterInterface {
    var presentMobilesIsCalled = false
    var presentErrorIsCalled = false
    
    func presentMobiles(response: MobileList.PresentMobile.Response) {
      presentMobilesIsCalled = true
    }
    
    func presentError() {
      presentErrorIsCalled = true
    }
  }
  
  class MobileListWorkerSpy: MobileListWorker {
    var getMobilesIsCalled = false
    
    override func getMobiles(_ completion: @escaping (Result<[Mobile]>) -> Void) {
      getMobilesIsCalled = true
      completion(Result.success([Seeds.Mobiles.xPhone2, Seeds.Mobiles.xPhone3G, Seeds.Mobiles.xPhoneX]))
    }
  }
  
  class DataManagerSpy: DataManagerProtocol {
    var addFavoriteIsCalled = false
    var removeFavoriteIsCalled = false
    var favoriteIDs: Set<Int>! = []
    
    func addFavorite(mobileID: Int) {
      addFavoriteIsCalled = true
      favoriteIDs.insert(mobileID)
    }
    
    func removeFavorite(mobileID: Int) {
      removeFavoriteIsCalled = true
      favoriteIDs.remove(mobileID)
    }
  }

  // MARK: - Tests
  
  func testGetMobilesShouldAskWorkerToGetMobilesAndPresenterToPresentMobiles() {
    // Given
    let mobileListPresenterSpy = MobileListInteractorOutputSpy()
    sut.presenter = mobileListPresenterSpy
    let mobileListWorkerSpy = MobileListWorkerSpy(store: MobileListStore())
    sut.worker = mobileListWorkerSpy
    
    // When
    sut.getMobiles(request: MobileList.GetMobiles.Request())
    
    // Then
    XCTAssert(mobileListWorkerSpy.getMobilesIsCalled)
    XCTAssert(mobileListPresenterSpy.presentMobilesIsCalled)
  }
  
  func testChangeListShouldAskPresenterToPresentMobiles() {
    // Given
    let mobileListPresenterSpy = MobileListInteractorOutputSpy()
    sut.presenter = mobileListPresenterSpy
    
    // When
    sut.changeList(request: MobileList.ChangeList.Request(listType: .favorite))
    
    // Then
    XCTAssert(mobileListPresenterSpy.presentMobilesIsCalled)
  }
  
  func testSortMobilesShouldAskPresenterToPresentMobiles() {
    // Given
    let mobileListPresenterSpy = MobileListInteractorOutputSpy()
    sut.presenter = mobileListPresenterSpy
    
    // When
    sut.sortMobiles(request: MobileList.SortMobiles.Request(sortingType: .priceHighToLow))
    
    // Then
    XCTAssert(mobileListPresenterSpy.presentMobilesIsCalled)
  }
  
  func testAddMobileToFavoriteShouldAskDataManagerToAddFavorite() {
    // Given
    sut.mobiles = [Seeds.Mobiles.xPhone2, Seeds.Mobiles.xPhoneX]
    let dataManagerSpy = DataManagerSpy()
    sut.dataManager = dataManagerSpy
    
    // When
    sut.addMobileToFavorite(request: MobileList.AddRemoveFavorite.Request(index: 0))
    
    // Then
    XCTAssert(dataManagerSpy.addFavoriteIsCalled)
    XCTAssert(dataManagerSpy.favoriteIDs.contains(Seeds.Mobiles.xPhone2.id!))
  }
  
  func testRemoveMobileFromFavoriteShouldAskDataManagerToRemoveFavorite() {
    // Given
    sut.mobiles = [Seeds.Mobiles.xPhone2, Seeds.Mobiles.xPhoneX]
    let dataManagerSpy = DataManagerSpy()
    dataManagerSpy.addFavorite(mobileID: Seeds.Mobiles.xPhone2.id!)
    dataManagerSpy.addFavorite(mobileID: Seeds.Mobiles.xPhoneX.id!)
    sut.dataManager = dataManagerSpy
    
    // When
    sut.removeMobileFromFavorite(request: MobileList.AddRemoveFavorite.Request(index: 1))
    
    // Then
    XCTAssert(dataManagerSpy.removeFavoriteIsCalled)
    XCTAssert(dataManagerSpy.favoriteIDs.contains(Seeds.Mobiles.xPhone2.id!))
    XCTAssertFalse(dataManagerSpy.favoriteIDs.contains(Seeds.Mobiles.xPhoneX.id!))
  }
}
