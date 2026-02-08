//
//  ViewController.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 1/20/26.
//

import UIKit

class TitleViewController: UIViewController, StartButtonDelegate {
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    self.view = TitleView(startButtonDelegate: self)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  func didTapStart() {
    let mainMenuVC = MainMenuViewController()
    mainMenuVC.modalPresentationStyle = .fullScreen
    present(mainMenuVC, animated: false)
  }
}

