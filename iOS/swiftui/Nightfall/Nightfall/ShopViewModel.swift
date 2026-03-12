//
//  ShopViewModel.swift
//  Nightfall
//
//  Created by Jimmy Lee on 1/24/26.
//


//import Foundation
import Combine
//import SwiftUI

class ShopViewModel: ObservableObject {
  @Published var player : Player
  @Published var boughtPotion = false
  @Published var boughtTrophy = false

  private let potionCost = 6
  private let trophyCost = 0
  let backgroundImageFileName = "shop"

  // Text
  let boughtPotionText = "You bought a potion."
  let notEnoughForPotionText = "You don't have enough gold to buy a potion."
  let notEnoughForAnotherPotionText = "You don't have enough gold to buy another potion."
  
  init(player: Player) {
    self.player = player
  }
  
  func canPlayerAffordPotion() -> Bool {
    return player.gold >= potionCost
  }
  
  func canPlayerAffordTrophy() -> Bool {
    return player.gold >= trophyCost
  }
  
  func buyPotionText() -> String {
    "Buy Potion (\(potionCost) g)"
  }
  
  func buyTrophyText() -> String {
    "Buy Trophy (\(trophyCost) g)"
  }

  func buyPotion() {
    boughtPotion = true
    player.gold -= potionCost
    player.potionCount += 1
  }
  
  func buyTrophy() { // should probably guard this
    boughtTrophy = true
    player.gold -= trophyCost
    player.wonGame = true
  }

  func remainingGoldText() -> String {
    return "Gold: \(player.gold)"
  }
}
