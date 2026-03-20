//
//  MainMenuViewController.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 2/8/26.
//

import UIKit

class MainMenuViewController: UIViewController, MainMenuDelegate {

  private let coordinator: GameCoordinator
  let mainMenuViewModel: MainMenuViewModel

  init(mainMenuViewModel: MainMenuViewModel, coordinator: GameCoordinator) {
    self.coordinator = coordinator
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
    coordinator.showInn(from: self)
  }

  func didTapShop() {
    coordinator.showShop(from: self)
  }

  func didTapItems() {
    coordinator.showItems(from: self)
  }

  func didTapBattle() {
    coordinator.showBattle(from: self)
  }

}
