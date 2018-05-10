//
//  MobileListViewController.swift
//  CleanMobilePrice
//
//  Created by Teerawat Vanasapdamrong on 3/5/2561 BE.
//  Copyright (c) 2561 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit

protocol MobileListViewControllerInterface: class {
  func displayMobiles(viewModel: MobileList.GetMobiles.ViewModel)
  func displayError()
}

class MobileListViewController: UIViewController, MobileListViewControllerInterface {
  var interactor: MobileListInteractorInterface!
  var router: MobileListRouter!
  var viewModel: MobileList.GetMobiles.ViewModel!
  
  @IBOutlet var tableView: UITableView!
  
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
  
  // MARK: - Display logic
  
  func displayMobiles(viewModel: MobileList.GetMobiles.ViewModel) {
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
      cell.displayCell(displayedMobile: viewModel.displayedMobiles![indexPath.row])
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
