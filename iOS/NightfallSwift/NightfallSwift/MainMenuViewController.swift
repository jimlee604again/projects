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
    let mainMenuView = MainMenuView(mainMenuViewModel: mainMenuViewModel)
    mainMenuView.mainMenuDelegate = self
    self.view = mainMenuView
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  override func viewDidAppear(_ animated: Bool) {
    updateMainMenuViewData()
  }

  func didTapInnButton() {
    let innViewModel = mainMenuViewModel.makeInnViewModel()
    let innVC = InnViewController(innViewModel: innViewModel)
    innVC.modalPresentationStyle = .fullScreen
    present(innVC, animated: false, completion: nil)
  }
  
  // MARK: TODO: do actual function
  func didTapBattleButton() {
    mainMenuViewModel.completeBattle()
    updateMainMenuViewData()
  }
  
  func updateMainMenuViewData() {
    if let mainMenuView = self.view as? MainMenuView {
        // Access MyCustomView properties
      mainMenuView.dataDidChange()
    }
  }
  
}

