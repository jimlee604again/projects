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
  var player1: PlayerLifeViewModel
  var player2: PlayerLifeViewModel
  var player1Of4: PlayerLifeViewModel
  var player2Of4: PlayerLifeViewModel
  var player3Of4: PlayerLifeViewModel
  var player4Of4: PlayerLifeViewModel
  var allPlayerModels: [PlayerLifeViewModel] = []

  init(withGame game: GameLifeData) {
    playerCount = game.playerCount
    player1 = PlayerLifeViewModel(
      withPlayer: game.player1,
      playerCount: .twoPlayer,
      shouldDisplayPoison: game.poisonEnabled
    )
    player2 = PlayerLifeViewModel(
      withPlayer: game.player2,
      playerCount: .twoPlayer,
      shouldDisplayPoison: game.poisonEnabled
    )
    player1Of4 = PlayerLifeViewModel(
      withPlayer: game.player1Of4,
      playerCount: .fourPlayer,
      shouldDisplayPoison: game.poisonEnabled
    )
    player2Of4 = PlayerLifeViewModel(
      withPlayer: game.player2Of4,
      playerCount: .fourPlayer,
      shouldDisplayPoison: game.poisonEnabled
    )
    player3Of4 = PlayerLifeViewModel(
      withPlayer: game.player3Of4,
      playerCount: .fourPlayer,
      shouldDisplayPoison: game.poisonEnabled
    )
    player4Of4 = PlayerLifeViewModel(
      withPlayer: game.player4Of4,
      playerCount: .fourPlayer,
      shouldDisplayPoison: game.poisonEnabled
    )
    allPlayerModels.append(player1)
    allPlayerModels.append(player2)
    allPlayerModels.append(player1Of4)
    allPlayerModels.append(player2Of4)
    allPlayerModels.append(player3Of4)
    allPlayerModels.append(player4Of4)
    super.init()
  }

  func togglePlayerCount() {
    switch playerCount {
    case .twoPlayer:
      playerCount = .fourPlayer
      break
    case .fourPlayer:
      playerCount = .twoPlayer
      break
    }
    notifyGameStateChange()
  }

  func togglePoison() {
    for playerModel in allPlayerModels {
      playerModel.togglePoison()
    }
    notifyGameStateChange()
  }

  func resetLife() {
    for playerModel in allPlayerModels {
      switch playerModel.playerCount {
      case .twoPlayer:
        playerModel.resetLife(life: startingLife2P)
        break
      case .fourPlayer:
        playerModel.resetLife(life: startingLife4P)
        break
      }
    }
    notifyGameStateChange()
  }

  private func notifyGameStateChange() {
    NotificationCenter.default.post(
      name: Notification.Name(
        rawValue: GameNotifications.GameStateDidChangeNotification
      ),
      object: self
    )
  }
}
