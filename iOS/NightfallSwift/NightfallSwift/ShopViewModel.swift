//
//  ShopViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/1/26.
//

import Foundation

class ShopViewModel {
  private let player: Player
  private let potionCost: Int32 = 5
  private let magicCrownCost: Int32 = 1
  
  let titleText: String = "Shop"
  let descriptionText: String = "Welcome to the shop, we are selling potions."
  let cantAffordText: String = "Not enough gold."
  var buyPotionButtonText: String {
    "Buy Potion (\(potionCost) gold)"
  }
  var buyMagicCrownButtonText: String {
    "Buy Magic Crown (\(magicCrownCost) gold)"
  }
  var goldText: String {
    "Gold: \(player.gold)"
  }
  
  init (player: Player) {
    self.player = player
  }
  
  func attemptBuyPotion() -> Bool {
    if player.gold >= potionCost {
      player.gold -= potionCost
      player.potionCount += 1
      return true
    }
    return false
  }
  
  func attemptBuyMagicCrown() -> Bool {
    if player.gold >= magicCrownCost {
      player.gold -= magicCrownCost
      player.magicCrownCount += 1
      // win the game?
    }
    return false
  }
  
}
