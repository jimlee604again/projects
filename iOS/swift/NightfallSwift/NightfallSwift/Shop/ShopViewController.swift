//
//  ShopViewController.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/1/26.
//

import UIKit

class ShopViewController: UIViewController, ShopViewDelegate {
  private let shopViewModel: ShopViewModel

  init(shopViewModel: ShopViewModel) {
    self.shopViewModel = shopViewModel
    super.init(nibName: nil, bundle: nil)
    let shopView = ShopView()
    shopView.configure(with: shopViewModel.viewState)
    shopViewModel.onStateChange = { [weak shopView] newState in
      shopView?.configure(with: newState)
    }
    self.view = shopView
    shopView.shopViewDelegate = self
  }
  
  func didTapBuyPotion() {
    switch shopViewModel.attemptBuyPotion() {
    case .success:
      presentSimpleAlert(title: shopViewModel.buyPotionAlertTitle, message: nil)
      break
    case .insufficientFunds:
      presentSimpleAlert(title: shopViewModel.insufficientFundsAlertTitle, message: nil)
      break
    }
  }
  
  func didTapBuyCrown() {
    switch shopViewModel.attemptBuyCrown() {
    case .success:
      presentSimpleAlert(title: shopViewModel.buyCrownAlertTitle,
                         message: shopViewModel.buyCrownAlertMessage)
      break
    case .insufficientFunds:
      presentSimpleAlert(title: shopViewModel.insufficientFundsAlertTitle, message: nil)
      break
    }
  }

  func didTapExit() {
    self.dismiss(animated: false)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
}
