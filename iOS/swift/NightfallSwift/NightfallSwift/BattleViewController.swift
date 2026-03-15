//
//  BattleViewController.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/12/26.
//

import UIKit

class BattleViewController: UIViewController {
  private let battleViewModel: BattleViewModel
  
  init(battleViewModel: BattleViewModel) {
    self.battleViewModel = battleViewModel
    super.init(nibName: nil, bundle: nil)
    self.view = BattleView(battleViewModel: battleViewModel)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
