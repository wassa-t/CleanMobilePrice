//
//  MobileListViewControllerTests.swift
//  CleanMobilePriceTests
//
//  Created by SCBUX on 11/5/2561 BE.
//  Copyright © 2561 Teerawat Vanasapdamrong. All rights reserved.
//

@testable import CleanMobilePrice
import XCTest

class MobileListViewControllerTests: XCTestCase {
  
  var sut: MobileListViewController!
  var window: UIWindow!
  
  override func setUp() {
    super.setUp()
    window = UIWindow()
    setUpMobileListViewController()
  }
  
  override func tearDown() {
    window = nil
    super.tearDown()
  }
  
  func setUpMobileListViewController() {
    let storyboared = UIStoryboard(name: "Main", bundle: nil)
    sut = storyboared.instantiateViewController(withIdentifier: "MobileListViewController") as! MobileListViewController
    window.addSubview(sut.view)
  }
  
  class MobileListViewControllerOutputSpy: MobileListInteractorInterface {
    var getMobilesIsCalled = false
    var setSelectedMobileIsCalled = false
    var sortMobilesIsCalled = false
    var changeListIsCalled = false
    var addMobileToFavoriteIsCalled = false
    var removeMobileFromFavoriteIsCalled = false
    var selectedMobile: Mobile?
    
    func getMobiles(request: MobileList.GetMobiles.Request) {
      getMobilesIsCalled = true
    }
    
    func setSelectedMobile(request: MobileList.SetSelectedMobile.Request) {
      setSelectedMobileIsCalled = true
    }
    
    func sortMobiles(request: MobileList.SortMobiles.Request) {
      sortMobilesIsCalled = true
    }
    
    func changeList(request: MobileList.ChangeList.Request) {
      changeListIsCalled = true
    }
    
    func addMobileToFavorite(request: MobileList.AddRemoveFavorite.Request) {
      addMobileToFavoriteIsCalled = true
    }
    
    func removeMobileFromFavorite(request: MobileList.AddRemoveFavorite.Request) {
      removeMobileFromFavoriteIsCalled = true
    }
  }
  
  func testGetMobilesOnLoadShouldAskInteractorToGetMobiles() {
    // Given
    let mobileListViewControllerOutputSpy = MobileListViewControllerOutputSpy()
    sut.interactor = mobileListViewControllerOutputSpy
    
    // When
    sut.getMobilesOnLoad()
    
    // Then
    XCTAssert(mobileListViewControllerOutputSpy.getMobilesIsCalled)
  }
  
  func testSectionTappedShouldAskInteractorToChangeList() {
    // Given
    let mobileListViewControllerOutputSpy = MobileListViewControllerOutputSpy()
    sut.interactor = mobileListViewControllerOutputSpy
    
    // When
    sut.sectionTapped(sender: sut.favoriteButton)
    
    // Then
    XCTAssert(mobileListViewControllerOutputSpy.changeListIsCalled)
    XCTAssert(sut.favoriteButton.isSelected)
    XCTAssertFalse(sut.allButton.isSelected)
  }
  
  func testSortTappedShouldPresentUIAlertController() {
    // Given
    let mobileListViewControllerOutputSpy = MobileListViewControllerOutputSpy()
    sut.interactor = mobileListViewControllerOutputSpy
    
    // When
    sut.sortTapped(sender: UIBarButtonItem())
    
    // Then
    XCTAssert(sut.presentedViewController is UIAlertController)
  }
  
  func testSortMobilesShouldAskInteractorToSortMobiles() {
    // Given
    let mobileListViewControllerOutputSpy = MobileListViewControllerOutputSpy()
    sut.interactor = mobileListViewControllerOutputSpy
    
    // When
    sut.sortMobiles(sortingType: .priceHighToLow)
    
    // Then
    XCTAssert(mobileListViewControllerOutputSpy.sortMobilesIsCalled)
  }
  
  func testAddMobileToFavoriteShouldAskInteractorToAddMobileToFavorite() {
    // Given
    let mobileListViewControllerOutputSpy = MobileListViewControllerOutputSpy()
    sut.interactor = mobileListViewControllerOutputSpy
    
    // When
    sut.addMobileToFavorite(at: 0)
    
    // Then
    XCTAssert(mobileListViewControllerOutputSpy.addMobileToFavoriteIsCalled)
  }
  
  func testRemoveMobileFromFavoriteShouldAskInteractorToRemoveMobileFromFavorite() {
    // Given
    let mobileListViewControllerOutputSpy = MobileListViewControllerOutputSpy()
    sut.interactor = mobileListViewControllerOutputSpy
    
    // When
    sut.removeMobileFromFavorite(at: 0)
    
    // Then
    XCTAssert(mobileListViewControllerOutputSpy.removeMobileFromFavoriteIsCalled)
  }
  
  func testDisplayMobilesShouldDisplayCorrectData() {
    // Given
    let viewModel = MobileList.PresentMobile.ViewModel(displayedMobiles: [Mobile.Displayed(name: "test name", description: "test description", price: "test price", rating: "test rating", thumbImageURL: URL(string: "www.google.com"), isFavorite: true)], listType: .all)
    
    // When
    sut.displayMobiles(viewModel: viewModel)
    
    // Then
    XCTAssert(sut.allButton.isSelected)
    XCTAssertFalse(sut.favoriteButton.isSelected)
    XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), viewModel.displayedMobiles?.count)
    let cell0 = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? MobileListTableViewCell
      XCTAssertNotNil(cell0)
    XCTAssertEqual(cell0?.nameLabel.text, "test name")
    XCTAssertEqual(cell0?.descriptionLabel.text, "test description")
    XCTAssertEqual(cell0?.priceLabel.text, "test price")
    XCTAssertEqual(cell0?.ratingLabel.text, "test rating")
    XCTAssert(cell0!.favoriteButton.isSelected)
  }
}
