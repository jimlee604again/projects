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
    if shopViewModel.attemptBuyPotion() {
    } else {
      let alertController = UIAlertController(title: shopViewModel.cantAffordText, message: nil, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: UIGuidelineAlertConfirm, style: .default))
      present(alertController, animated: false)
    }
  }
  
  func didTapBuyCrown() {
    if shopViewModel.attemptBuyCrown() {
      let alertController = UIAlertController(title: shopViewModel.isFirstWin ? shopViewModel.winGameText : shopViewModel.repeatWinText, message: nil, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: UIGuidelineAlertConfirm, style: .default))
      present(alertController, animated: false)
    } else {
      let alertController = UIAlertController(title: shopViewModel.cantAffordText, message: nil, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: UIGuidelineAlertConfirm, style: .default))
      present(alertController, animated: false)
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
