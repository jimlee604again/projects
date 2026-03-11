//
//  ItemsViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/1/26.
//

import Foundation

class ItemsViewModel {
  private let player : Player
  
  // MARK: Text
  let titleText: String = "Items"
  var potionsCountText : String {
    "Potions: \(player.potionCount)"
  }
  var crownsCountText : String {
    "Crowns: \(player.crownCount)"
  }
  
  init (player: Player) {
    self.player = player
  }
}
