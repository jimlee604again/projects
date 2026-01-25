//
//  ItemsViewModel.swift
//  Nightfall
//
//  Created by Jimmy Lee on 1/25/26.
//

import Foundation
import Combine
import SwiftUI

//@MainActor
class ItemsViewModel: ObservableObject {
  @Published var player : Player
  private let potionHealValue = 10
  let backgroundImageFileName = "items"

  // Text
  let usePotionText = "Use Potion"
//  let notEnoughForPotionText = "You don't have enough gold to buy a potion."
//  let notEnoughForAnotherPotionText = "You don't have enough gold to buy another potion."
  
  init(player: Player) {
    self.player = player
  }
  
  func playerHasPotions() -> Bool {
    return player.potionCount > 0
  }
  
  func playerUsedPotion() {
    player.potionCount -= 1
    player.hp += potionHealValue
  }
  
  func potionsRemainingText() -> String {
    return "Potions remaining: \(player.potionCount)"
  }
}
