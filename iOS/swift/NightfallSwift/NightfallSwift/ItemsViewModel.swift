//
//  ItemsViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/1/26.
//

import Foundation

class ItemsViewModel {
  private let gameState: GameState
  
  // MARK: Text
  let titleText: String = "Items"
  var potionsCountText : String {
    "Potions: \(gameState.player.potionCount)"
  }
  var crownsCountText : String {
    "Crowns: \(gameState.player.crownCount)"
  }

  init (gameState: GameState) {
    self.gameState = gameState
  }
}
