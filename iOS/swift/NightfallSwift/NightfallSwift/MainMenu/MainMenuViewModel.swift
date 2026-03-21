//
//  MainMenuViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 2/24/26.
//

import Foundation

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
    didSet { onDidChange?(viewState) }
  }
  var onDidChange: ((MainMenuViewState) -> Void)?

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

  func playerHealthDisplayText() -> String {
    "HP: \(gameState.snapshot.hp)"
  }

  func playerGoldDisplayText() -> String {
    "Gold: \(gameState.snapshot.gold)"
  }

  deinit {
    guard let gameStateObserverID else { return }
    gameState.removeObserver(gameStateObserverID)
  }

}
