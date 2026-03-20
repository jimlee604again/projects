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
  let potionCost = Int32(5)
  let crownCost = Int32(1)
}

struct ShopViewState {
  let titleText: String = "Shop"
  let pageDescriptionText: String = "Shop til you drop."
  let buyPotionText : String
  let buyCrownText : String
  let hpAmountText : String
  let goldAmountText : String
  let potionAmountText : String
  let crownAmountText : String

  init(parameters : ShopParameters,
       potionAmount: Int32,
       crownAmount: Int32,
       hpAmount: Int32,
       goldAmount: Int32) {
    buyPotionText = "Buy Potion\n(\(parameters.potionCost) gold)"
    buyCrownText = "Buy Crown\n(\(parameters.crownCost) gold)"
    potionAmountText = "Potions: \(potionAmount)"
    crownAmountText = "Crowns: \(crownAmount)"
    hpAmountText = "HP: \(hpAmount)"
    goldAmountText = "Gold: \(goldAmount)"
  }
}

class ShopViewModel {
  private(set) var viewState : ShopViewState {
    didSet { onStateChange?(viewState) }
  }
  var onStateChange: ((ShopViewState) -> Void)?

  private let gameState: GameState
  private let parameters = ShopParameters()

  let insufficientFundsAlertTitle = "Insuffient funds."
  let winGameText: String = "Congratulations, you got the magic crown and now you rule the world! See how many crowns you can collect."
  var repeatWinText: String {
    "Congratulations on crown number \(gameState.snapshot.crownCount)!"
  }
  let buyPotionAlertTitle = "Potion Purchased!"
  let buyCrownAlertTitle = "Crown Purchased!"
  var buyCrownAlertMessage: String {
    gameState.snapshot.crownCount == 1 ? winGameText : repeatWinText
  }

  init(gameState: GameState) {
    self.gameState = gameState
    let snapshot = gameState.snapshot
    self.viewState = ShopViewState(parameters: parameters,
                                   potionAmount: snapshot.potionCount,
                                   crownAmount: snapshot.crownCount,
                                   hpAmount: snapshot.hp,
                                   goldAmount: snapshot.gold)
  }

  func updateViewState () {
    let snapshot = gameState.snapshot
    viewState = ShopViewState(parameters: parameters,
                              potionAmount: snapshot.potionCount,
                              crownAmount: snapshot.crownCount,
                              hpAmount: snapshot.hp,
                              goldAmount: snapshot.gold)
  }

  func attemptBuyPotion() -> PurchaseResult {
    if gameState.buyPotion(cost: parameters.potionCost) {
      updateViewState()
      return .success
    }
    return .insufficientFunds
  }

  func attemptBuyCrown() -> PurchaseResult {
    if gameState.buyCrown(cost: parameters.crownCost) {
      updateViewState()
      return .success
    }
    return .insufficientFunds
  }

}
