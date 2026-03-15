//
//  InnViewController.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 2/11/26.
//

import UIKit

class InnViewController: UIViewController, InnViewDelegate {
  private let innViewModel: InnViewModel

  init(innViewModel: InnViewModel) {
    self.innViewModel = innViewModel
    super.init(nibName: nil, bundle: nil)
    let innView = InnView()
    self.view = innView
    innView.configureWith(InnViewState(title: innViewModel.titleText, stayButtonText: innViewModel.stayButtonText))
    innViewModel.onStateChange = { [weak innView] state in
        innView?.configureWith(state)
    }
    innView.innViewDelegate = self
  }

  func didTapStay() {
    switch innViewModel.attemptStay() {
    case .success:
      self.dismiss(animated: false)
      break
    case .insufficientFunds:
      let alertController = UIAlertController(title: innViewModel.notEnoughGoldTitle, message: innViewModel.notEnoughGoldDescription, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: UIGuidelineAlertConfirm, style: .default))
      present(alertController, animated: false)
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
