//
//  BattleViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/1/26.
//

import Foundation

struct BattleViewState {
  let titleText = "Battle"
  let battleButtonText = "Battle"
  let outcomeExplanationText : String
  let hpLabelText : String
  let goldLabelText : String

  init(parameters: BattleParameters, hp: Int32, gold: Int32) {
    outcomeExplanationText = "You will lose \(parameters.hpLoss) health and gain \(parameters.goldGain) gold."
    hpLabelText = "HP: \(hp)"
    goldLabelText = "Gold: \(gold)"
  }
}

class BattleViewModel {
  private let gameState: GameState
  private(set) var viewState: BattleViewState {
      didSet { onStateChange?(viewState) }
  }
  var onStateChange: ((BattleViewState) -> Void)?
  let battleParameters = BattleParameters()

  init (gameState: GameState) {
    self.gameState = gameState
    self.viewState = BattleViewState(parameters: battleParameters,
                                     hp: gameState.snapshot.hp,
                                     gold: gameState.snapshot.gold)
  }

  func battle() -> BattleResult {
    let result = gameState.battle(battleParameters)
    self.viewState = BattleViewState(parameters: battleParameters,
                                     hp: gameState.snapshot.hp,
                                     gold: gameState.snapshot.gold)
    return result
  }
}
