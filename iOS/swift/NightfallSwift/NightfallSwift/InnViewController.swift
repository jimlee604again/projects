//
//  InnViewController.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 2/11/26.
//

import UIKit

class InnViewController: UIViewController, InnViewDelegate {
  private var innViewModel: InnViewModel

  init(innViewModel: InnViewModel) {
    self.innViewModel = innViewModel
    super.init(nibName: nil, bundle: nil)
    let innView = InnView()
    self.view = innView
    self.innViewModel.onStateChange = { [weak innView] state in
        innView?.configureWith(state)
    }
    innView.configureWith(innViewModel.viewState)
    innView.innViewDelegate = self
  }

  func didTapStay() {
    switch innViewModel.attemptStay() {
    case .success:
      presentSimpleAlert(title: innViewModel.staySuccessTitle, message: innViewModel.staySuccessMessage)
      break
    case .insufficientFunds:
      presentSimpleAlert(title: innViewModel.notEnoughGoldTitle, message: innViewModel.notEnoughGoldMessage)
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
