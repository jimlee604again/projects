//
//  ViewController.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 1/20/26.
//

import UIKit

class ViewController: UIViewController {
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    self.view = TitleView()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

}

