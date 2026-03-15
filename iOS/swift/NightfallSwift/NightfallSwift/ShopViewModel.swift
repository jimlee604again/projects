//
//  ShopViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/1/26.
//

import Foundation

class ShopViewModel {
  private let gameState: GameState
  private let potionCost: Int32 = 5
  private let magicCrownCost: Int32 = 1
  
  let titleText: String = "Shop"
  let descriptionText: String = "Welcome to the shop, we are selling potions."
  let cantAffordText: String = "Not enough gold."
  let winGameText: String = "Congratulations, you got the magic crown and now you rule the world! See how many crowns you can collect."
  var buyPotionButtonText: String {
    "Buy Potion\n(\(potionCost) gold)"
  }
  var buyMagicCrownButtonText: String {
    "Buy Crown\n(\(magicCrownCost) gold)"
  }
  var potionCountText: String {
    "Potions: \(gameState.player.potionCount)"
  }
  var goldText: String {
    "Gold: \(gameState.player.gold)"
  }
  var isFirstWin: Bool {
    gameState.player.crownCount == 1
  }
  var repeatWinText: String {
    "Congratulations on crown number \(gameState.player.crownCount)!"
  }
  
  init (gameState: GameState) {
    self.gameState = gameState
  }
  
  func attemptBuyPotion() -> Bool {
    if gameState.player.gold >= potionCost {
      gameState.player.gold -= potionCost
      gameState.player.potionCount += 1
      return true
    }
    return false
  }
  
  func attemptBuyMagicCrown() -> Bool {
    if gameState.player.gold >= magicCrownCost {
      gameState.player.gold -= magicCrownCost
      gameState.player.crownCount += 1
      return true
      // win the game?
    }
    return false
  }
  
}
