//
//  MainMenuViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 2/24/26.
//

import Foundation

protocol MainMenuViewModelDelegate: AnyObject {
  func mainMenuViewModel(_ viewModel: MainMenuViewModel, didUpdate viewState: MainMenuViewState)
}

struct MainMenuViewState {
  let title = "Main Menu"
  let innTitle = "Inn"
  let shopTitle = "Shop"
  let itemsTitle = "Items"
  let battleTitle = "Battle"
  let hpText : String
  let goldText : String

  init(hp: Int32, gold: Int32) {
    hpText = "HP: \(hp)"
    goldText = "Gold: \(gold)"
  }
}

public class MainMenuViewModel {
  private let gameState: GameState
  private var gameStateObserverID: UUID?
  private(set) var viewState : MainMenuViewState {
    didSet { delegate?.mainMenuViewModel(self, didUpdate: viewState) }
  }
  weak var delegate: MainMenuViewModelDelegate?

  init(gameState: GameState) {
    self.gameState = gameState
    let snapshot = gameState.snapshot
    self.viewState = Self.makeViewState(snapshot: snapshot)
    self.gameStateObserverID = gameState.addObserver { [weak self] snapshot in
      self?.viewState = Self.makeViewState(snapshot: snapshot)
    }
  }

  private static func makeViewState(snapshot: GameStateSnapshot) -> MainMenuViewState {
    MainMenuViewState(hp: snapshot.hp, gold: snapshot.gold)
  }

  func makeInnViewModel() -> InnViewModel {
    InnViewModel(gameState: gameState)
  }

  func makeShopViewModel() -> ShopViewModel {
    ShopViewModel(gameState: gameState)
  }

  func makeItemsViewModel() -> ItemsViewModel {
    ItemsViewModel(gameState: gameState)
  }

  func makeBattleViewModel() -> BattleViewModel {
    BattleViewModel(gameState: gameState)
  }

  deinit {
    guard let gameStateObserverID else { return }
    gameState.removeObserver(gameStateObserverID)
  }

}
