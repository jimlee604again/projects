//
//  InnViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 2/24/26.
//

import Foundation

struct InnViewModel {
  // MARK: Data In
  private let player: Player
  
  // MARK: Logic Values
  private let stayCost : Int32 = 20
  private let hpRestoreAmount : Int32 = 10
  
  // MARK: Content
  let titleText: String = "Inn"
  let stayButtonText: String = "Stay"
  
  init(player: Player) {
    self.player = player
  }
  
  /// - Returns: if the stay transaction is successful. If false, an error message should be presented
  func attemptStay() -> Bool {
    if player.gold >= stayCost {
      player.gold -= stayCost
      player.hp += hpRestoreAmount
      return true
    } else {
      return false
    }
  }
}
