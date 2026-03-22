//
//  ItemsViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/1/26.
//

import Foundation

protocol ItemsViewModelDelegate: AnyObject {
  func itemsViewModel(_ viewModel: ItemsViewModel, didUpdate viewState: ItemsViewState)
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
    didSet { delegate?.itemsViewModel(self, didUpdate: viewState) }
  }
  private let parameters = ItemsParameters()

  weak var delegate: ItemsViewModelDelegate?

  let usedPotionAlertTitle = "Potion Used"
  let noPotionsLeftAlertTitle = "No Potions Left"
  var usedPotionAlertMessage: String {
    "You restored \(parameters.potionHealAmount) HP!"
  }

  init (gameState: GameState) {
    self.gameState = gameState
    viewState = Self.makeViewState(parameters: parameters, snapshot: gameState.snapshot)
  }

  private static func makeViewState(parameters: ItemsParameters, snapshot : GameStateSnapshot) -> ItemsViewState {
    ItemsViewState(parameters: parameters,
                   potionAmount: snapshot.potionCount,
                   crownAmount: snapshot.crownCount,
                   hp: snapshot.hp,
                   gold: snapshot.gold)
  }

  private func updateViewState() {
    viewState = Self.makeViewState(parameters: parameters, snapshot: gameState.snapshot)
  }

  func attemptUsePotion() -> UseItemResult {
    if gameState.usePotion(healAmount: parameters.potionHealAmount) {
      updateViewState()
      return .used
    } else {
      return .noneLeft
    }
  }
}
