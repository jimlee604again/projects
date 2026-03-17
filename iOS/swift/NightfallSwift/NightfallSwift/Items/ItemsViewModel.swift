//
//  ItemsViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/1/26.
//

import Foundation

enum UseItemResult { case used, noneLeft }

struct ItemsViewState {
  let usePotionText = "Use Potion"
  let title = "Items"
  let pageDescription : String
  let potionHealAmount: Int32
  let potionAmountText: String
  let crownAmountText: String
  
  init(potionHealAmount: Int32, potionAmount: Int32, crownAmount: Int32) {
    self.potionHealAmount = potionHealAmount
    self.pageDescription = "Potions will heal you \(potionHealAmount) HP."
    self.potionAmountText = "Potions: \(potionAmount)"
    self.crownAmountText = "Crowns: \(crownAmount)"
  }
}

class ItemsViewModel {
  private let gameState: GameState
  private(set) var viewState : ItemsViewState {
    didSet { onStateChange?(viewState) }
  }
  
  let potionHealAmount: Int32 = 5
  
  var onStateChange: ((ItemsViewState) -> Void)?
  
  // MARK: Text
  var potionsCountText : String {
    "Potions: \(gameState.player.potionCount)"
  }
  var crownsCountText : String {
    "Crowns: \(gameState.player.crownCount)"
  }

  init (gameState: GameState) {
    self.gameState = gameState
    self.viewState = ItemsViewState(potionHealAmount: potionHealAmount,
                                    potionAmount: gameState.player.potionCount,
                                    crownAmount: gameState.player.crownCount)
  }
  
  let usedPotionAlertTitle: String = "Potion Used"
  var usedPotionAlertMessage: String {
    "You restored \(potionHealAmount) HP!"
  }

  func attemptUsePotion() -> UseItemResult {
    if gameState.player.potionCount > 0 {
      gameState.player.potionCount -= 1
      gameState.player.hp += potionHealAmount
      viewState = ItemsViewState(potionHealAmount: potionHealAmount,
                                 potionAmount: gameState.player.potionCount,
                                 crownAmount: gameState.player.crownCount)
      return .used
    } else {
      return .noneLeft
    }
  }
}
