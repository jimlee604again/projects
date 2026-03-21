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
  let parameters = BattleParameters()

  init (gameState: GameState) {
    self.gameState = gameState
    self.viewState = Self.makeViewState(parameters: parameters, snapshot: gameState.snapshot)
  }

  private static func makeViewState(parameters: BattleParameters, snapshot: GameStateSnapshot) -> BattleViewState {
    BattleViewState(parameters: parameters, hp: snapshot.hp, gold: snapshot.gold)
  }

  private func updateViewState() {
    self.viewState = Self.makeViewState(parameters: parameters, snapshot: gameState.snapshot)
  }

  func battle() -> BattleResult {
    let result = gameState.battle(parameters)
    updateViewState()
    return result
  }
}
