//
//  MobileDetailsConfigurator.swift
//  CleanMobilePrice
//
//  Created by SCBUX on 4/5/2561 BE.
//  Copyright (c) 2561 Teerawat Vanasapdamrong. All rights reserved.
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension MobileDetailsViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }

  @IBAction func unwindToMobileDetailsViewController(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
  }
}

class MobileDetailsConfigurator {

  // MARK: - Object lifecycle

  static let sharedInstance = MobileDetailsConfigurator()

  private init() {}

  // MARK: - Configuration

  func configure(viewController: MobileDetailsViewController) {
    let router = MobileDetailsRouter()
    router.viewController = viewController

    let presenter = MobileDetailsPresenter()
    presenter.viewController = viewController

    let interactor = MobileDetailsInteractor()
    interactor.presenter = presenter
    interactor.worker = MobileDetailsWorker(store: MobileDetailsStore())

    viewController.interactor = interactor
    viewController.router = router
  }
}
