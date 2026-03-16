//
//  BattleViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/1/26.
//

import Foundation

enum BattleResult { case winBattle, loseBattle}

struct BattleParameters {
  let hpLoss : Int32 = 5
  let goldGain : Int32 = 10
}

struct BattleViewState {
  let titleText = "Battle"
  let outcomeExplanationText = "You will lose X HP, but gain Y gold."
  let battleButtonText = "Battle"
  let hpLabelText : String
  let goldLabelText : String
  let battleParameters = BattleParameters()
  
  init(hp: Int32, gold: Int32) {
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

  init (gameState: GameState) {
    self.gameState = gameState
    self.viewState = BattleViewState(hp: gameState.player.hp, gold: gameState.player.gold)
  }
  
  func battle() -> BattleResult {
    let result = gameState.battle(viewState.battleParameters)
    self.viewState = BattleViewState(hp: gameState.player.hp, gold: gameState.player.gold)
    return result
  }
}
