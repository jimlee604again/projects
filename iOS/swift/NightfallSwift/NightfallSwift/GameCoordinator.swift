//
//  GameCoordinator.swift
//  NightfallSwift
//
//  Created by Codex on 3/19/26.
//

import UIKit

final class GameCoordinator {
  private let playerRepository: PlayerRepository
  private var gameState: GameState?

  init(playerRepository: PlayerRepository = .shared) {
    self.playerRepository = playerRepository
  }

  func makeTitleViewController() -> TitleViewController {
    TitleViewController(coordinator: self)
  }

  private func makeMainMenuViewController(player: Player? = nil) -> MainMenuViewController {
    let resolvedPlayer = player ?? playerRepository.loadOrCreatePlayer()
    let gameState = GameState(player: resolvedPlayer)
    self.gameState = gameState

    return MainMenuViewController(
      mainMenuViewModel: MainMenuViewModel(gameState: gameState),
      coordinator: self
    )
  }

  private func makeInnViewController() -> InnViewController {
    InnViewController(innViewModel: InnViewModel(gameState: requireGameState()))
  }

  private func makeShopViewController() -> ShopViewController {
    ShopViewController(shopViewModel: ShopViewModel(gameState: requireGameState()))
  }

  private func makeItemsViewController() -> ItemsViewController {
    ItemsViewController(itemsViewModel: ItemsViewModel(gameState: requireGameState()))
  }

  private func makeBattleViewController() -> BattleViewController {
    BattleViewController(battleViewModel: BattleViewModel(gameState: requireGameState()))
  }

  func start(in window: UIWindow) {
    window.rootViewController = makeTitleViewController()
    window.makeKeyAndVisible()
  }

  func showMainMenu(from presenter: UIViewController,
                    player: Player? = nil,
                    animated: Bool = false) {
    let viewController = makeMainMenuViewController(player: player)
    viewController.modalPresentationStyle = .fullScreen
    presenter.present(viewController, animated: animated)
  }

  func showInn(from presenter: UIViewController, animated: Bool = false) {
    let viewController = makeInnViewController()
    viewController.modalPresentationStyle = .fullScreen
    presenter.present(viewController, animated: animated)
  }

  func showShop(from presenter: UIViewController, animated: Bool = false) {
    let viewController = makeShopViewController()
    viewController.modalPresentationStyle = .fullScreen
    presenter.present(viewController, animated: animated)
  }

  func showItems(from presenter: UIViewController, animated: Bool = false) {
    let viewController = makeItemsViewController()
    viewController.modalPresentationStyle = .fullScreen
    presenter.present(viewController, animated: animated)
  }

  func showBattle(from presenter: UIViewController, animated: Bool = false) {
    let viewController = makeBattleViewController()
    viewController.modalPresentationStyle = .fullScreen
    presenter.present(viewController, animated: animated)
  }

  private func requireGameState() -> GameState {
    guard let gameState else {
      fatalError("GameState is unavailable. Present the main menu before creating game screens.")
    }

    return gameState
  }
}
