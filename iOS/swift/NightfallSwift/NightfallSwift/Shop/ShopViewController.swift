//
//  ShopViewController.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/1/26.
//

import UIKit

class ShopViewController: UIViewController, ShopViewDelegate, ShopViewModelDelegate {
  private let shopViewModel: ShopViewModel

  init(shopViewModel: ShopViewModel) {
    self.shopViewModel = shopViewModel
    super.init(nibName: nil, bundle: nil)
  }

  override func loadView() {
    let shopView = ShopView()
    shopView.shopViewDelegate = self
    view = shopView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    shopViewModel.delegate = self
    if let shopView = view as? ShopView {
      shopView.configure(with: shopViewModel.viewState)
    }
  }

  func shopViewModel(_ viewModel: ShopViewModel, didUpdate viewState: ShopViewState) {
    (view as? ShopView)?.configure(with: viewState)
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

}
