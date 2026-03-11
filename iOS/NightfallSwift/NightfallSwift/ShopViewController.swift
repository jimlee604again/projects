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
    let shopView = ShopView(shopViewModel: shopViewModel)
    self.view = shopView
    shopView.shopViewDelegate = self
  }
  
  func didTapBuyPotion() {
    if shopViewModel.attemptBuyPotion() {
      updateShopViewData()
    } else {
      let alertController = UIAlertController(title: shopViewModel.cantAffordText, message: nil, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: UIGuidelineAlertConfirm, style: .default))
      present(alertController, animated: false)
    }
  }
  
  func didTapBuyMagicCrown() {
    if shopViewModel.attemptBuyMagicCrown() {
      updateShopViewData()
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

  func updateShopViewData() {
    if let shopView = self.view as? ShopView {
        // Access MyCustomView properties
      shopView.dataDidChange()
    }
  }
  
}
