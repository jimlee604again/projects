//
//  BattleViewController.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/12/26.
//

import UIKit

class BattleViewController: UIViewController, BattleViewDelegate {
  private let battleViewModel: BattleViewModel
  
  init(battleViewModel: BattleViewModel) {
    self.battleViewModel = battleViewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    let battleView = BattleView()
    self.battleViewModel.onStateChange = { [weak battleView] state in
      battleView?.configure(state)
    }
    battleView.delegate = self
    view = battleView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let battleView = self.view as? BattleView {
      battleView.configure(battleViewModel.viewState)
    }
  }
  
  func didTapBattle() {
    switch battleViewModel.battle() {
    case .loseBattle:
      let alert = UIAlertController(title: "You Lose", message: nil, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: UIGuidelineAlertConfirm, style: .default))
      present(alert, animated: false)
    case .winBattle:
      let alert = UIAlertController(title: "You Win", message: nil, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: UIGuidelineAlertConfirm, style: .default))
      present(alert, animated: false)
    }
  }
  
  func didTapExit() {
    self.dismiss(animated: false)
  }
}
