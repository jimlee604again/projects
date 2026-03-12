//
//  PlayerLifeViewModelFromPlayer.swift
//  LifeHack
//
//  Created by Jimmy Lee on 12/2/23.
//

import Foundation

class PlayerLifeViewModel: NSObject {
  var player: PlayerLifeData
  var life: Int {
    get {
      return self.player.life
    }
  }
  var poison: Int {
    get {
      return player.poison
    }
  }
  var playerCount: PlayerCount
  var shouldDisplayPoison: Bool
  
  init(withPlayer player: PlayerLifeData,
       playerCount: PlayerCount,
       shouldDisplayPoison: Bool) {
    self.player = player
    self.playerCount = playerCount
    self.shouldDisplayPoison = shouldDisplayPoison
    super.init()
  }
  
  func incrementLife() {
    player.life += 1
    notifyLifeUpdate()
  }

  func decrementLife() {
    player.life -= 1
    notifyLifeUpdate()
  }
  
  func incrementPoison() {
    player.poison += 1
    notifyLifeUpdate()
  }
  func decrementPoison() {
    player.poison -= 1
    notifyLifeUpdate()
  }

  func togglePoison() {
    self.shouldDisplayPoison = !self.shouldDisplayPoison
  }

  func resetLife(life: Int) {
    player.life = life
    player.poison = startingPoison
  }
  
  private func notifyLifeUpdate() {
    NotificationCenter.default.post(name: Notification.Name(rawValue: GameNotifications.GameStateDidChangeNotification), object: self)
  }
  
}
