//
//  GameLifeViewModelFromGame.swift
//  LifeHack
//
//  Created by Jimmy Lee on 12/2/23.
//

import Foundation

let startingLife2P: Int = 20
let startingLife4P: Int = 40
let startingPoison: Int = 0

enum GameNotifications {
  static let GameStateDidChangeNotification = "GameStateDidChangeNotification"
  static let GameDidTapResetNotification = "GameStateDidTapResetNotification"
}

class GameLifeViewModel: NSObject {
  var playerCount: PlayerCount
  var poisonEnabled: Bool
  var player1: PlayerLifeViewModel
  var player2: PlayerLifeViewModel
  var player1Of4: PlayerLifeViewModel
  var player2Of4: PlayerLifeViewModel
  var player3Of4: PlayerLifeViewModel
  var player4Of4: PlayerLifeViewModel
  
  
  init(withGame game: GameLifeData) {
    self.playerCount = game.playerCount
    self.poisonEnabled = game.poisonEnabled
    self.player1 = PlayerLifeViewModel(withPlayer: game.player1, playerCount: .twoPlayer, shouldDisplayPoison: game.poisonEnabled)
    self.player2 = PlayerLifeViewModel(withPlayer: game.player2, playerCount: .twoPlayer, shouldDisplayPoison: game.poisonEnabled)
    self.player1Of4 = PlayerLifeViewModel(withPlayer: game.player1Of4, playerCount: .fourPlayer, shouldDisplayPoison: game.poisonEnabled)
    self.player2Of4 = PlayerLifeViewModel(withPlayer: game.player2Of4, playerCount: .fourPlayer, shouldDisplayPoison: game.poisonEnabled)
    self.player3Of4 = PlayerLifeViewModel(withPlayer: game.player3Of4, playerCount: .fourPlayer, shouldDisplayPoison: game.poisonEnabled)
    self.player4Of4 = PlayerLifeViewModel(withPlayer: game.player4Of4, playerCount: .fourPlayer, shouldDisplayPoison: game.poisonEnabled)
    super.init()
  }
  
  func togglePlayerCount() {
    switch self.playerCount {
    case .twoPlayer:
      self.playerCount = .fourPlayer
    case .fourPlayer:
      self.playerCount = .twoPlayer
    }
    notifyGameStateChange()
  }

  func togglePoison() {
    let newPoisonEnabledValue = !self.poisonEnabled
    self.poisonEnabled = newPoisonEnabledValue
    player1.togglePoison()
    player2.togglePoison()
    player1Of4.togglePoison()
    player2Of4.togglePoison()
    player3Of4.togglePoison()
    player4Of4.togglePoison()
    notifyGameStateChange()
  }
  
  func resetLife() {
    player1.resetLife(life: startingLife2P)
    player2.resetLife(life: startingLife2P)
    player1Of4.resetLife(life: startingLife4P)
    player2Of4.resetLife(life: startingLife4P)
    player3Of4.resetLife(life: startingLife4P)
    player4Of4.resetLife(life: startingLife4P)
    notifyGameStateChange()
  }
  
  private func notifyGameStateChange() {
    NotificationCenter.default.post(name: Notification.Name(rawValue: GameNotifications.GameStateDidChangeNotification), object: self)
  }
}
