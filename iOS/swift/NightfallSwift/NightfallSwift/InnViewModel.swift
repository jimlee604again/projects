//
//  InnViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 2/24/26.
//

import Foundation

enum StayResult { case success, insufficientFunds }

struct InnViewState {
  let title: String
  let stayButtonText: String
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
  private let hpRestoreAmount : Int32 = 10
  
  // MARK: Content
  let titleText = "Inn"
  let stayButtonText = "Stay"
  let notEnoughGoldTitle = "Insufficient Funds"
  let notEnoughGoldDescription = "Not enough gold to stay at the inn."
  
  init(gameState: GameState) {
    self.gameState = gameState
    self.viewState = InnViewState(title: titleText, stayButtonText: stayButtonText)
  }

  func attemptStay() -> StayResult {
    if gameState.player.gold >= stayCost {
      gameState.player.gold -= stayCost
      gameState.player.hp += hpRestoreAmount
      return .success
    }
    return .insufficientFunds
  }
}
