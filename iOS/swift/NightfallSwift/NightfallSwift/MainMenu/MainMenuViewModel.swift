//
//  MainMenuViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 2/24/26.
//

import Combine
import Foundation

struct MainMenuViewState {
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

public class MainMenuViewModel: ObservableObject {
  @Published private var gameState: GameState
  private(set) var viewState : MainMenuViewState {
    didSet { onDidChange?(viewState) }
  }
  var onDidChange: ((MainMenuViewState) -> Void)?
  
  init(gameState: GameState) {
    self.gameState = gameState
    self.viewState = MainMenuViewState(hp: gameState.player.hp,
                                       gold: gameState.player.gold)
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
  
  func completeBattle() {
    gameState.player.hp -= 3
    gameState.player.gold += 10
  }
  
  func playerHealthDisplayText() -> String {
    return "HP: \(gameState.player.hp)"
  }
  
  func playerGoldDisplayText() -> String {
    return "Gold: \(gameState.player.gold)"
  }
}
