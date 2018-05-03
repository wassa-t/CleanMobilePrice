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
    // NOTE: Display the result from the Presenter
    
    // nameTextField.text = viewModel.name
  }
  
  func displayError() {
    
  }
}
