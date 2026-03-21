//
//  InnViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 2/24/26.
//

import Foundation

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
  private let parameters = InnParameters()

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
    self.viewState = Self.makeViewState(parameters: parameters, snapshot: gameState.snapshot)
    self.staySuccessMessage = "You feel rested. Recovered \(parameters.recoverAmount) HP."
  }

  private static func makeViewState(parameters: InnParameters, snapshot: GameStateSnapshot) -> InnViewState {
    InnViewState(parameters, hp: snapshot.hp, gold: snapshot.gold)
  }

  private func updateViewState() {
    self.viewState = Self.makeViewState(parameters: parameters, snapshot: gameState.snapshot)
  }

  func attemptStay() -> StayResult {
    if gameState.stayAtInn(cost: parameters.stayCost, recoverAmount: parameters.recoverAmount) {
      updateViewState()
      return .success
    }
    return .insufficientFunds
  }
}
