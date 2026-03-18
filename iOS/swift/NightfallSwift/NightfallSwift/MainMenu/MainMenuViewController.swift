//
//  MainMenuViewController.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 2/8/26.
//

import UIKit

class MainMenuViewController: UIViewController, MainMenuDelegate {

  let mainMenuViewModel: MainMenuViewModel
  
  init(mainMenuViewModel: MainMenuViewModel) {
    self.mainMenuViewModel = mainMenuViewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    let mainMenuView = MainMenuView()
    mainMenuView.mainMenuDelegate = self
    mainMenuViewModel.onDidChange = { [weak mainMenuView] viewState in
      mainMenuView?.configure(with: viewState)
    }
    self.view = mainMenuView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    if let mainMenuView = self.view as? MainMenuView {
      mainMenuView.configure(with: mainMenuViewModel.viewState)
    }
  }

  func didTapInn() {
    let innViewModel = mainMenuViewModel.makeInnViewModel()
    let innVC = InnViewController(innViewModel: innViewModel)
    innVC.modalPresentationStyle = .fullScreen
    present(innVC, animated: false, completion: nil)
  }
  
  func didTapShop() {
    let shopViewModel = mainMenuViewModel.makeShopViewModel()
    let shopVC = ShopViewController(shopViewModel: shopViewModel)
    shopVC.modalPresentationStyle = .fullScreen
    present(shopVC, animated: false, completion: nil)
  }
  
  func didTapItems() {
    let itemsViewModel = mainMenuViewModel.makeItemsViewModel()
    let itemsVC = ItemsViewController(itemsViewModel: itemsViewModel)
    itemsVC.modalPresentationStyle = .fullScreen
    present(itemsVC, animated: false, completion: nil)
  }

  func didTapBattle() {
    let battleViewModel = mainMenuViewModel.makeBattleViewModel()
    let battleVC = BattleViewController(battleViewModel: battleViewModel)
    battleVC.modalPresentationStyle = .fullScreen
    present(battleVC, animated: false, completion: nil)
  }

}

