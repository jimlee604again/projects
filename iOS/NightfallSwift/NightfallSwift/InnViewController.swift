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
    let innView = InnView(innViewModel: innViewModel)
    self.view = innView
    innView.innViewDelegate = self
  }
  
  func didTapStay() {
    if (innViewModel.attemptStay()) {
      self.dismiss(animated: false)
    } else {
      let alertController = UIAlertController(title: "Insufficient Funds", message: "Not enough gold to stay at the inn.", preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "OK", style: .default))
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
