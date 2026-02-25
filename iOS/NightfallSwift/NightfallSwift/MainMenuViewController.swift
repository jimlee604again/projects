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
    self.view = MainMenuView(mainMenuViewModel: mainMenuViewModel, mainMenuDelegate: self)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  func didTapInnButton() {
    print("tapped inn button")
    
    let innViewModel = mainMenuViewModel.makeInnViewModel()
    let innVC = InnViewController(innViewModel: innViewModel)
    innVC.modalPresentationStyle = .fullScreen
    present(innVC, animated: false, completion: nil)
  }
  
}

