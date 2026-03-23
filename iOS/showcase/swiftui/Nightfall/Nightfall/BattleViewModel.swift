//
//  BattleViewModel.swift
//  Nightfall
//
//  Created by Jimmy Lee on 1/25/26.
//

//import Foundation
import Combine
//import SwiftUI

//@MainActor
class BattleViewModel: ObservableObject {
  @Published var player : Player
  @Published var playerDied : Bool = false
  @Published var playerWon : Bool = false

  private let hpLoss = 5
  private let goldGain = 8
  
  let backgroundImageFileName = "battle"

  // Text
  let battleButtonText = "Battle"
  let returnButtonText = "Return"
  let playerDiedText = "You have died."
  
  init(player: Player) {
    self.player = player
  }
  
  func playerWonText() -> String {
    return "You emerge victorious.\nWould you like to fight again?\nYou will lose \(hpLoss) hp and gain \(goldGain) gold."
  }
  
  func askToBattleText() -> String {
    "Would you like to battle?\nYou will lose \(hpLoss) hp and gain \(goldGain) gold."
  }
  
  func remainingHPText() -> String {
    return "HP: \(player.hp)"
  }
  
  func remainingGoldText() -> String {
    return "Gold: \(player.gold)"
  }
  
  func resolveBattle() {
    player.hp -= hpLoss
    if player.hp <= 0 {
      playerDied = true
    } else {
      player.gold += goldGain
      playerWon = true
    }
  }
}
