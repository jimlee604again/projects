//
//  InnViewModel.swift
//  Nightfall
//
//  Created by Jimmy Lee on 12/26/25.
//

import Combine

class InnViewModel: ObservableObject {
  @Published var player: Player
  @Published var stayed = false
  
  let healAmount = 10
  let stayCost = 2
  let backgroundImageFileName = "inn"
  
  // Text
  let leaveText = "Leave Inn"
  let stayedText = "You stay for the night and wake up feeling refreshed. Healed 10 hp."
  let cantAffordText = "It seems you cannot afford to stay with us."
  
  init(player: Player) {
    self.player = player
  }
  
  func canPlayerAffordInn() -> Bool {
    return player.gold >= stayCost
  }
  
  func invokePlayerStaysAtInn() {
    stayed = true
    player.gold -= stayCost
    player.hp += healAmount
  }
  
  func welcomeText() -> String {
    return "Welcome to the inn! \(stayCost) gold per night."
  }
  
  func payGoldText() -> String {
    "Pay \(stayCost) gold"
  }
 
  func remainingGoldText() -> String {
    return "Gold: \(player.gold)"
  }
}
