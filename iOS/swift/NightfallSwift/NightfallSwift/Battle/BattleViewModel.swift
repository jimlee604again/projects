//
//  BattleViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/1/26.
//

import Foundation

enum BattleResult { case winBattle, loseBattle}

struct BattleParameters {
  let hpLoss : Int32 = 6
  let goldGain : Int32 = 10
}

struct BattleViewState {
  let titleText = "Battle"
  let battleButtonText = "Battle"
  let outcomeExplanationText : String
  let hpLabelText : String
  let goldLabelText : String
  
  init(hp: Int32, gold: Int32, battleParameters: BattleParameters) {
    outcomeExplanationText = "You will lose \(battleParameters.hpLoss) health and gain \(battleParameters.goldGain) gold."
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
    self.viewState = BattleViewState(hp: gameState.player.hp,
                                     gold: gameState.player.gold,
                                     battleParameters: BattleParameters())
  }
  
  func battle() -> BattleResult {
    let result = gameState.battle(battleParameters)
    self.viewState = BattleViewState(hp: gameState.player.hp, gold: gameState.player.gold, battleParameters: battleParameters)
    return result
  }
}
