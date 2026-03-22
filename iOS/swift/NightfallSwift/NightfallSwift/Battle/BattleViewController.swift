//
//  BattleViewController.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/12/26.
//

import UIKit

class BattleViewController: UIViewController, BattleViewDelegate, BattleViewModelDelegate {
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
    battleView.delegate = self
    view = battleView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    battleViewModel.delegate = self
    if let battleView = self.view as? BattleView {
      battleView.configure(battleViewModel.viewState)
    }
  }

  func battleViewModel(_ viewModel: BattleViewModel, didUpdate viewState: BattleViewState) {
    (view as? BattleView)?.configure(viewState)
  }

  func didTapBattle() {
    switch battleViewModel.battle() {
    case .loseBattle:
      // MARK: TODO: replace with presenting a you lose screen and try again button.
      presentSimpleAlert(title: battleViewModel.loseMessage, message: nil)
    case .winBattle:
      presentSimpleAlert(title: battleViewModel.winMessage, message: nil)
    }
  }

  func didTapExit() {
    self.dismiss(animated: false)
  }
}
