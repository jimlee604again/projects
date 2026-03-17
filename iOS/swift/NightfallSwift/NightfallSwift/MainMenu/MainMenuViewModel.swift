//
//  MainMenuViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 2/24/26.
//

import Combine
import Foundation

public class MainMenuViewModel: ObservableObject {
  @Published private var gameState: GameState
  
  init(gameState: GameState) {
    self.gameState = gameState
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
