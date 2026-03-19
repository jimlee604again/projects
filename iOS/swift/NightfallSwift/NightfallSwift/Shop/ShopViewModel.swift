//
//  ShopViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/1/26.
//

import Foundation

enum PurchaseResult {
  case success
  case insufficientFunds
}

struct ShopParameters {
  let potionCost: Int32
  let crownCost: Int32
  let potionAmount: Int32
  let crownAmount: Int32
  let goldAmount: Int32
}

struct ShopViewState {
  let titleText: String = "Shop"
  let pageDescriptionText: String = "Shop til you drop."
  let buyPotionText : String
  let buyCrownText : String
  let potionAmountText : String
  let crownAmountText : String
  let goldAmountText : String

  init(_ parameters : ShopParameters) {
    buyPotionText = "Buy Potion\n(\(parameters.potionCost) gold)"
    buyCrownText = "Buy Crown\n(\(parameters.crownCost) gold)"
    potionAmountText = "Potions: \(parameters.potionAmount)"
    crownAmountText = "Crowns: \(parameters.crownAmount)"
    goldAmountText = "Gold: \(parameters.goldAmount)"
  }
}

class ShopViewModel {
  private(set) var viewState : ShopViewState {
    didSet { onStateChange?(viewState) }
  }
  var onStateChange: ((ShopViewState) -> Void)?

  private let gameState: GameState

  let insufficientFundsAlertTitle = "Insuffient funds."
  let winGameText: String = "Congratulations, you got the magic crown and now you rule the world! See how many crowns you can collect."
  var repeatWinText: String {
    "Congratulations on crown number \(gameState.player.crownCount)!"
  }
  let buyPotionAlertTitle = "Potion Purchased!"
  let buyCrownAlertTitle = "Crown Purchased!"
  var buyCrownAlertMessage: String {
    gameState.player.crownCount == 1 ? winGameText : repeatWinText
  }

  let potionCost = Int32(5)
  let crownCost = Int32(1)

  init(gameState: GameState) {
    self.gameState = gameState
    let snapshot = gameState.snapshot
    self.viewState = ShopViewState(ShopParameters(potionCost: potionCost,
                                                  crownCost: crownCost,
                                                  potionAmount: snapshot.potionCount,
                                                  crownAmount: snapshot.crownCount,
                                                  goldAmount: snapshot.gold))
  }

  func updateViewState () {
    let snapshot = gameState.snapshot
    viewState = ShopViewState(ShopParameters(potionCost: potionCost,
                                             crownCost: crownCost,
                                             potionAmount: snapshot.potionCount,
                                             crownAmount: snapshot.crownCount,
                                             goldAmount: snapshot.gold))
  }

  func attemptBuyPotion() -> PurchaseResult {
    if gameState.buyPotion(cost: potionCost) {
      updateViewState()
      return .success
    }
    return .insufficientFunds
  }

  func attemptBuyCrown() -> PurchaseResult {
    if gameState.buyCrown(cost: crownCost) {
      updateViewState()
      return .success
    }
    return .insufficientFunds
  }

}
