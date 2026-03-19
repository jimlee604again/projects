//
//  ItemsViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/1/26.
//

import Foundation

enum UseItemResult { case used, noneLeft }

struct ItemsParameters {
  let potionHealAmount: Int32 = 5
}

struct ItemsViewState {
  let usePotionText = "Use Potion"
  let title = "Items"
  let pageDescription : String
  let potionHealAmount: Int32
  let potionAmountText: String
  let crownAmountText: String
  let hpText: String
  let goldText: String

  init(parameters: ItemsParameters,
       potionAmount: Int32,
       crownAmount: Int32,
       hp: Int32,
       gold: Int32) {
    self.potionHealAmount = parameters.potionHealAmount
    self.pageDescription = "Potions will heal you \(parameters.potionHealAmount) HP."
    self.potionAmountText = "Potions: \(potionAmount)"
    self.crownAmountText = "Crowns: \(crownAmount)"
    self.hpText = "HP: \(hp)"
    self.goldText = "Gold: \(gold)"
  }
}

class ItemsViewModel {
  private let gameState: GameState
  private(set) var viewState : ItemsViewState {
    didSet { onStateChange?(viewState) }
  }
  private let itemsParameters = ItemsParameters()

  var onStateChange: ((ItemsViewState) -> Void)?

  init (gameState: GameState) {
    self.gameState = gameState
    self.viewState = ItemsViewState(parameters: itemsParameters,
                                    potionAmount: gameState.player.potionCount,
                                    crownAmount: gameState.player.crownCount,
                                    hp: gameState.player.hp,
                                    gold: gameState.player.gold)
  }

  let usedPotionAlertTitle = "Potion Used"
  let noPotionsLeftAlertTitle = "No Potions Left"
  var usedPotionAlertMessage: String {
    "You restored \(itemsParameters.potionHealAmount) HP!"
  }

  func attemptUsePotion() -> UseItemResult {
    if gameState.usePotion(healAmount: itemsParameters.potionHealAmount) {
      viewState = ItemsViewState(parameters: itemsParameters,
                                 potionAmount: gameState.player.potionCount,
                                 crownAmount: gameState.player.crownCount,
                                 hp: gameState.player.hp + itemsParameters.potionHealAmount,
                                 gold: gameState.player.gold)
      return .used
    } else {
      return .noneLeft
    }
  }
}
