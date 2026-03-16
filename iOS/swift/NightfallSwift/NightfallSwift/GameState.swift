//
//  GameState.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/14/26.
//

import Foundation

public class GameState {
  
  let innPrice: Int32 = 3
  
  let player: Player
  
  init(player: Player) {
    self.player = player
  }
  
  func canStayAtInn() -> Bool {
    return player.gold >= innPrice
  }
  
  func stayAtInn() {
    if canStayAtInn() {
      player.gold -= innPrice
    } else {
      print("Attempted to stay at inn without enough gold.")
    }
  }
 
  func battle(_ battleParameters: BattleParameters) -> BattleResult {
    player.hp -= battleParameters.hpLoss

    if player.hp <= 0 {
      player.hp = 0
      return .loseBattle
    } else {
      player.gold += battleParameters.goldGain
      return .winBattle
    }
  }
  
}
