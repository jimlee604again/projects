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
    self.viewState = MainMenuViewState(hp: snapshot.hp,
                                       gold: snapshot.gold)
    self.gameStateObserverID = gameState.addObserver { [weak self] snapshot in
      self?.viewState = MainMenuViewState(hp: snapshot.hp,
                                          gold: snapshot.gold)
    }
  }
  
  func makeInnViewModel() -> InnViewModel {
    return InnViewModel(gameState: gameState)
  }
  
  func makeShopViewModel() -> ShopViewModel {
    return ShopViewModel(gameState: gameState)
  }
  
  func makeItemsViewModel() -> ItemsViewModel {
    return ItemsViewModel(gameState: gameState)
  }
  
  func makeBattleViewModel() -> BattleViewModel {
    return BattleViewModel(gameState: gameState)
  }
  
  func playerHealthDisplayText() -> String {
    return "HP: \(gameState.snapshot.hp)"
  }
  
  func playerGoldDisplayText() -> String {
    return "Gold: \(gameState.snapshot.gold)"
  }

  deinit {
    guard let gameStateObserverID else { return }
    gameState.removeObserver(gameStateObserverID)
  }

}
