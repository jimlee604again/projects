//
//  GameState.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/14/26.
//

import Foundation

struct GameStateSnapshot {
  let hp: Int32
  let gold: Int32
  let potionCount: Int32
  let crownCount: Int32
}

public class GameState {
  private var observers: [UUID: (GameStateSnapshot) -> Void] = [:]
  
  let innPrice: Int32 = 3
  
  let player: Player
  
  init(player: Player) {
    self.player = player
  }

  var snapshot: GameStateSnapshot {
    GameStateSnapshot(hp: player.hp,
                      gold: player.gold,
                      potionCount: player.potionCount,
                      crownCount: player.crownCount)
  }

  @discardableResult
  func addObserver(_ observer: @escaping (GameStateSnapshot) -> Void) -> UUID {
    let id = UUID()
    observers[id] = observer
    observer(snapshot)
    return id
  }

  func removeObserver(_ id: UUID) {
    observers.removeValue(forKey: id)
  }

  private func notifyObservers() {
    let currentSnapshot = snapshot
    observers.values.forEach { $0(currentSnapshot) }
  }
  
  func canStayAtInn() -> Bool {
    return player.gold >= innPrice
  }
  
  func stayAtInn() {
    if canStayAtInn() {
      player.gold -= innPrice
      notifyObservers()
    } else {
      print("Attempted to stay at inn without enough gold.")
    }
  }

  func stayAtInn(cost: Int32, recoverAmount: Int32) -> Bool {
    guard player.gold >= cost else {
      return false
    }

    player.gold -= cost
    player.hp += recoverAmount
    notifyObservers()
    return true
  }
 
  func battle(_ battleParameters: BattleParameters) -> BattleResult {
    player.hp -= battleParameters.hpLoss

    if player.hp <= 0 {
      player.hp = 0
      notifyObservers()
      return .loseBattle
    } else {
      player.gold += battleParameters.goldGain
      notifyObservers()
      return .winBattle
    }
  }

  func buyPotion(cost: Int32) -> Bool {
    guard player.gold >= cost else {
      return false
    }

    player.gold -= cost
    player.potionCount += 1
    notifyObservers()
    return true
  }

  func buyCrown(cost: Int32) -> Bool {
    guard player.gold >= cost else {
      return false
    }

    player.gold -= cost
    player.crownCount += 1
    notifyObservers()
    return true
  }

  func usePotion(healAmount: Int32) -> Bool {
    guard player.potionCount > 0 else {
      return false
    }

    player.potionCount -= 1
    player.hp += healAmount
    notifyObservers()
    return true
  }
  
}
