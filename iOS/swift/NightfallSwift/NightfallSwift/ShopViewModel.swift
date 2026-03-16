//
//  ShopViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/1/26.
//

import Foundation

struct ShopViewState {
  let titleText: String = "Shop"
  let pageDescriptionText: String = "Shop til you drop."
  let buyPotionText : String
  let buyCrownText : String
  let potionAmountText : String
  let crownAmountText : String
  let goldAmountText : String
  
  init(potionCost: Int32, crownCost: Int32, potionAmount: Int32, crownAmount: Int32, goldAmount: Int32) {
    buyPotionText = "Buy Potion\n(\(potionCost) gold)"
    buyCrownText = "Buy Crown\n(\(crownCost) gold)"
    potionAmountText = "Potions: \(potionAmount)"
    crownAmountText = "Crowns: \(crownAmount)"
    goldAmountText = "Gold: \(goldAmount)"
  }
}

class ShopViewModel {
  private(set) var viewState : ShopViewState {
    didSet { onStateChange?(viewState) }
  }
  var onStateChange: ((ShopViewState) -> Void)?

  private let gameState: GameState
  private let potionCost: Int32 = 5
  private let crownCost: Int32 = 1
  
  let cantAffordText: String = "Not enough gold."
  let winGameText: String = "Congratulations, you got the magic crown and now you rule the world! See how many crowns you can collect."
  var isFirstWin: Bool {
    gameState.player.crownCount == 1
  }
  var repeatWinText: String {
    "Congratulations on crown number \(gameState.player.crownCount)!"
  }
  
  init(gameState: GameState) {
    self.gameState = gameState
    self.viewState = ShopViewState(potionCost: potionCost,
                                       crownCost: crownCost,
                                       potionAmount: gameState.player.potionCount,
                                       crownAmount: gameState.player.crownCount,
                                       goldAmount: gameState.player.gold)
  }
  
  // change to enum
  func attemptBuyPotion() -> Bool {
    if gameState.player.gold >= potionCost {
      gameState.player.gold -= potionCost
      gameState.player.potionCount += 1
      return true
    }
    return false
  }
  
  func attemptBuyCrown() -> Bool {
    if gameState.player.gold >= crownCost {
      gameState.player.gold -= crownCost
      gameState.player.crownCount += 1
      return true
      // win the game?
    }
    return false
  }
  
}
