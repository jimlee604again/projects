//
//  InnViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 2/24/26.
//

import Foundation

enum StayResult { case success, insufficientFunds }

struct InnParameters {
  let stayCost: Int32 = 2
  let recoverAmount: Int32 = 10
}

struct InnViewState {
  let title = "Inn"
  let outcomeExplanation: String
  let stayButtonText = "Stay"
  let hpText: String
  let goldText: String

  init(_ parameters: InnParameters, hp: Int32, gold: Int32) {
    outcomeExplanation = "You will pay \(parameters.stayCost) gold to recover \(parameters.recoverAmount) HP."
    hpText = "HP: \(hp)"
    goldText = "Gold: \(gold)"
  }
}

class InnViewModel {
  // MARK: Data In
  private let gameState: GameState
  private(set) var viewState: InnViewState {
      didSet { onStateChange?(viewState) }
  }
  private let innParameters = InnParameters()

  var onStateChange: ((InnViewState) -> Void)?

  // MARK: Content
  let titleText = "Inn"
  let stayButtonText = "Stay"
  let staySuccessTitle = "Zzz..."
  let staySuccessMessage: String
  let notEnoughGoldTitle = "Insufficient Funds"
  let notEnoughGoldMessage = "Not enough gold to stay at the inn."

  init(gameState: GameState) {
    self.gameState = gameState
    self.viewState = InnViewState(innParameters,
                                  hp: gameState.player.hp,
                                  gold: gameState.player.gold)
    self.staySuccessMessage = "You feel rested. Recovered \(innParameters.recoverAmount) HP."
  }

  func attemptStay() -> StayResult {
    if gameState.stayAtInn(cost: innParameters.stayCost, recoverAmount: innParameters.recoverAmount) {
      self.viewState = InnViewState(innParameters,
                               hp: gameState.player.hp,
                               gold: gameState.player.gold)
      return .success
    }
    return .insufficientFunds
  }
}
