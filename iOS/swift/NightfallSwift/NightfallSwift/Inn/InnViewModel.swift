//
//  InnViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 2/24/26.
//

import Foundation

enum StayResult { case success, insufficientFunds }

struct InnViewState {
  let title = "Inn"
  let outcomeExplanation: String
  let stayButtonText = "Stay"
  
  init(stayCost : Int32, recoverAmount : Int32) {
    outcomeExplanation = "You will pay \(stayCost) gold to recover \(recoverAmount) HP."
  }
}

struct InnViewModel {
  // MARK: Data In
  private let gameState: GameState
  private(set) var viewState: InnViewState {
      didSet { onStateChange?(viewState) }
  }

  var onStateChange: ((InnViewState) -> Void)?
  
  // MARK: Logic Values
  private let stayCost : Int32 = 2
  private let recoverAmount : Int32 = 10
  
  // MARK: Content
  let titleText = "Inn"
  let stayButtonText = "Stay"
  let staySuccessTitle = "Zzz..."
  let staySuccessMessage: String
  let notEnoughGoldTitle = "Insufficient Funds"
  let notEnoughGoldMessage = "Not enough gold to stay at the inn."
  
  init(gameState: GameState) {
    self.gameState = gameState
    self.viewState = InnViewState(stayCost: stayCost, recoverAmount: recoverAmount)
    self.staySuccessMessage = "You feel rested. Gained \(recoverAmount) HP."
  }

  func attemptStay() -> StayResult {
    if gameState.player.gold >= stayCost {
      gameState.player.gold -= stayCost
      gameState.player.hp += recoverAmount
      return .success
    }
    return .insufficientFunds
  }
}
