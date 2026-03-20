//
//  ViewController.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 1/20/26.
//

import UIKit

class TitleViewController: UIViewController, StartButtonDelegate {

  private let coordinator: GameCoordinator
  let titleViewModel: TitleViewModel = TitleViewModel()
  var fetchedPlayer: Player?

  init(coordinator: GameCoordinator) {
    self.coordinator = coordinator
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    let titleView = TitleView()
    titleView.startButtonDelegate = self
    view = titleView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    fetchedPlayer = PlayerRepository.shared.loadOrCreatePlayer()
    if let titleView = self.view as? TitleView {
      titleView.configure(with: titleViewModel.viewState)
    }
  }

  func didTapStart() {
    coordinator.showMainMenu(from: self, player: fetchedPlayer)
  }

}
