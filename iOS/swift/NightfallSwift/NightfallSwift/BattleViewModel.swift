//
//  BattleViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/1/26.
//

import Foundation

class BattleViewModel {
  private let gameState: GameState

  let titleText = "Battle"

  init (gameState: GameState) {
    self.gameState = gameState
  }
}
