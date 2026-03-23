//
//  MainMenuViewModel.swift
//  Nightfall
//
//  Created by Jimmy Lee on 1/26/26.
//

import Combine

class MainMenuViewModel: ObservableObject {
  @Published var player : Player

  // Text
  let mainMenuTitle = "Main Menu"
  let innTitle = "Inn"
  let shopTitle = "Shop"
  let itemsTitle = "Items"
  let battleTitle = "Battle"

  init(player: Player) {
    self.player = player
  }

  func playerHP() -> String {
    return "HP: \(player.hp)"
  }
  
  func playerGold() -> String {
    return "Gold: \(player.gold)"
  }
  
  func handlePlayerDeath() {
    if player.hp <= 0 {
      player.hp = 10
      player.gold = 0
      player.potionCount = 0
    }
  }
}
