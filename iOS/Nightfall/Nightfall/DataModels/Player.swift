//
//  Item.swift
//  Nightfall
//
//  Created by Jimmy Lee on 12/11/25.
//

import Foundation
import SwiftData

@Model
final class Player {
  var hp: Int
  var gold: Int
  var potionCount: Int // item/inventory
  
  init(hp: Int, gold: Int, potionCount: Int) {
    self.hp = hp
    self.gold = gold
    self.potionCount = potionCount
  }

}
