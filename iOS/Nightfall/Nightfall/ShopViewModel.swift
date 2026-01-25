//
//  ShopViewModel.swift
//  Nightfall
//
//  Created by Jimmy Lee on 1/24/26.
//


import Foundation
import Combine
import SwiftUI

//@MainActor
class ShopViewModel: ObservableObject {
  @Published var player : Player
  @Published var boughtPotion = false

  private let potionCost = 6
  let backgroundImageFileName = "shop"

  // Text
  let boughtPotionText = "You bought a potion."
  let buyPotionText = "Buy Potion"
  let notEnoughForPotionText = "You don't have enough gold to buy a potion."
  let notEnoughForAnotherPotionText = "You don't have enough gold to buy another potion."
  
  init(player: Player) {
    self.player = player
  }
  
  func canPlayerAffordPotion() -> Bool {
    return player.gold >= potionCost
  }

  func buyPotion() {
    boughtPotion = true
    player.gold -= potionCost
    player.potionCount += 1
  }

  func remainingGoldText() -> String {
    return "Gold: \(player.gold)"
  }
}
