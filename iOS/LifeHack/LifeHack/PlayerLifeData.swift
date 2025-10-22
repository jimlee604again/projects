//
//  PlayerLifeData.swift
//  LifeHack
//
//  Created by Jimmy Lee on 12/1/23.
//

import Foundation

struct PlayerLifeData {
  var life: Int
  var poison: Int
  
  init(playerLife: Int, playerPoison: Int) {
    self.life = playerLife
    self.poison = playerPoison
  }
}
