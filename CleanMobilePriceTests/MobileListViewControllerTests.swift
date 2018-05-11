//
//  MobileListViewControllerTests.swift
//  CleanMobilePriceTests
//
//  Created by SCBUX on 11/5/2561 BE.
//  Copyright © 2561 Teerawat Vanasapdamrong. All rights reserved.
//

import XCTest
@testable import CleanMobilePrice

class MobileListViewControllerTests: XCTestCase {
  
  var mobileListViewController: MobileListViewController!
  var window: UIWindow!
  
  override func setUp() {
    super.setUp()
    window = UIWindow()
    setUpMobileListViewController()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func setUpMobileListViewController() {
    let storyboared = UIStoryboard(name: "Main", bundle: nil)
    mobileListViewController = storyboared.instantiateViewController(withIdentifier: "MobileListViewController") as! MobileListViewController
    window.addSubview(mobileListViewController.view)
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
    mobileListViewController.interactor = mobileListViewControllerOutputSpy
    
    // When
    mobileListViewController.getMobilesOnLoad()
    
    // Then
    XCTAssert(mobileListViewControllerOutputSpy.getMobilesIsCalled)
  }
  
  func test<#something#>Should<#do something#>() {
  	// Given
  	<#given#>
  
  	// When
  	<#when#>
  
  	// Then
  	<#then#>
  }
}
