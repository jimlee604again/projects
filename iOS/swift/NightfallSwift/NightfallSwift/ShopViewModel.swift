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
  let winGameText: String = "Congratulations, you got the magic crown and now you rule the world! See how many crowns you can collect."
  var buyPotionButtonText: String {
    "Buy Potion\n(\(potionCost) gold)"
  }
  var buyMagicCrownButtonText: String {
    "Buy Crown\n(\(magicCrownCost) gold)"
  }
  var potionCountText: String {
    "Potions: \(player.potionCount)"
  }
  var goldText: String {
    "Gold: \(player.gold)"
  }
  var isFirstWin: Bool {
    player.crownCount == 1
  }
  var repeatWinText: String {
    "Congratulations on crown number \(player.crownCount)!"
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
      player.crownCount += 1
      return true
      // win the game?
    }
    return false
  }
  
}
