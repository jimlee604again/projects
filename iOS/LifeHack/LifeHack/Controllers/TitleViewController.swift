//
//  ViewController.swift
//  LifeHack
//
//  Created by Jimmy Lee on 11/23/23.
//

import UIKit

class TitleViewController: UIViewController {

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    self.view = TitleView(frame: self.view.frame, 
                          presentLifeTrackerAction: #selector(presentLifeTracker),
                          presentingController:self)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    UIApplication.shared.isIdleTimerDisabled = true
  }

  @objc func presentLifeTracker() {
    let lifeTrackerVC = LifeTrackerViewController()
    lifeTrackerVC.modalPresentationStyle = .fullScreen
    self.present(lifeTrackerVC, animated: false)
  }
  
}

