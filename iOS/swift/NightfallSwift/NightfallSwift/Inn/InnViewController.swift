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
  }

  override func loadView() {
    let innView = InnView()
    self.innViewModel.onStateChange = { [weak innView] state in
        innView?.configureWith(state)
    }
    innView.innViewDelegate = self
    view = innView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    if let innView = self.view as? InnView {
      innView.configureWith(innViewModel.viewState)
    }
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

}
