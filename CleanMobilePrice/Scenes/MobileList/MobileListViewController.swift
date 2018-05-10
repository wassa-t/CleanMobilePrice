//
//  MobileListViewController.swift
//  CleanMobilePrice
//
//  Created by Teerawat Vanasapdamrong on 3/5/2561 BE.
//  Copyright (c) 2561 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit

protocol MobileListViewControllerInterface: class {
  func displayMobiles(viewModel: MobileList.PresentMobile.ViewModel)
  func displayError()
}

class MobileListViewController: UIViewController, MobileListViewControllerInterface {
  var interactor: MobileListInteractorInterface!
  var router: MobileListRouter!
  var viewModel: MobileList.PresentMobile.ViewModel!
  
  @IBOutlet var tableView: UITableView!
  @IBOutlet var allButton: UIButton!
  @IBOutlet var favoriteButton: UIButton!
  
  // MARK: - Object lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    MobileListConfigurator.sharedInstance.configure(viewController: self)
  }
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getMobilesOnLoad()
  }
  
  // MARK: - Event handling
  
  func getMobilesOnLoad() {
    // NOTE: Ask the Interactor to do some work
    
    let request = MobileList.GetMobiles.Request()
    interactor.getMobiles(request: request)
  }
  
  @IBAction func sortTapped(sender: UIBarButtonItem) {
    let alertController = UIAlertController(title: "Sort", message: nil, preferredStyle: .alert)
    let ascPriceAction = UIAlertAction(title: "Price low to high", style: .default) { [weak self] action in
      self?.sortMobiles(sortingType: .priceLowToHigh)
    }
    let descPriceAction = UIAlertAction(title: "Price high to low", style: .default) { [weak self] action in
      self?.sortMobiles(sortingType: .priceHighToLow)
    }
    let ratingAction = UIAlertAction(title: "Rating", style: .default) { [weak self] action in
      self?.sortMobiles(sortingType: .rating)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { alert in
      
    }
    alertController.addAction(ascPriceAction)
    alertController.addAction(descPriceAction)
    alertController.addAction(ratingAction)
    alertController.addAction(cancelAction)
    
    self.present(alertController, animated: true)
  }
  
  @IBAction func sectionTapped(sender: UIButton) {
    allButton.isSelected = false
    favoriteButton.isSelected = false
    sender.isSelected = true
    let listType: ListType = sender == favoriteButton ? .favorite : .all
    let request = MobileList.ChangeList.Request(listType: listType)
    interactor.changeList(request: request)
  }
  
  private func sortMobiles(sortingType: SortingType) {
    let request = MobileList.SortMobiles.Request(sortingType: sortingType)
    interactor.sortMobiles(request: request)
  }
  
  // MARK: - Display logic
  
  func displayMobiles(viewModel: MobileList.PresentMobile.ViewModel) {
    self.viewModel = viewModel
    tableView.reloadData()
  }
  
  func displayError() {
    
  }
}

extension MobileListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.displayedMobiles?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneCell", for: indexPath) as? MobileListTableViewCell {
      cell.favoriteButton.isHidden = viewModel.listType == .favorite
      cell.displayCell(displayedMobile: viewModel.displayedMobiles![indexPath.row])
      cell.index = indexPath.row
      cell.delegate = self
      return cell
    }
    return UITableViewCell()
  }
}

extension MobileListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    interactor.setSelectedMobile(request: MobileList.SetSelectedMobile.Request(selectedIndex: indexPath.row))
    router.navigateToDetails()
  }
}

extension MobileListViewController: MobileListTableViewCellDelegate {
  func addMobileToFavorite(at index: Int) {
    let request = MobileList.AddRemoveFavorite.Request(index: index)
    interactor.addMobileToFavorite(request: request)
  }
  
  func removeMobileFromFavorite(at index: Int) {
    let request = MobileList.AddRemoveFavorite.Request(index: index)
    interactor.removeMobileFromFavorite(request: request)
  }
}
