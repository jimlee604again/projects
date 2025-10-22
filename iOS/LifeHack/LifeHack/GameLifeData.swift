//
//  LifeData.swift
//  LifeHack
//
//  Created by Jimmy Lee on 11/30/23.
//

import Foundation

enum PlayerCount {
  case twoPlayer, fourPlayer
}

class GameLifeData: NSObject {
  var playerCount: PlayerCount
  var poisonEnabled: Bool
  var player1: PlayerLifeData
  var player2: PlayerLifeData
  var player1Of4: PlayerLifeData
  var player2Of4: PlayerLifeData
  var player3Of4: PlayerLifeData
  var player4Of4: PlayerLifeData
  
  init(playerCount: PlayerCount, 
       displayPoison: Bool,
       p1LifeData: PlayerLifeData,
       p2LifeData: PlayerLifeData,
       p1Of4LifeData: PlayerLifeData,
       p2Of4LifeData: PlayerLifeData,
       p3Of4LifeData: PlayerLifeData,
       p4Of4LifeData: PlayerLifeData) {
    self.playerCount = playerCount
    self.poisonEnabled = displayPoison
    self.player1 = p1LifeData
    self.player2 = p2LifeData
    self.player1Of4 = p1Of4LifeData
    self.player2Of4 = p2Of4LifeData
    self.player3Of4 = p3Of4LifeData
    self.player4Of4 = p4Of4LifeData
  }
}
