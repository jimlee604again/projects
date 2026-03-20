//
//  PlayerRepository.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 3/19/26.
//

import Foundation
import CoreData

struct DefaultPlayerStats {
  let hp = Int32(10)
  let gold = Int32(0)
}

public class PlayerRepository {
  
  static let shared = PlayerRepository()
  
  func loadOrCreatePlayer() -> Player {
    let context = CoreDataManager.shared.context
    let players = fetchPlayers()

    if let existingPlayer = players.first {
      return existingPlayer
    }

    // Generate base player if a persisted one isn't fetched.
    guard let entity = NSEntityDescription.entity(
      forEntityName: "Player",
      in: context
    ) else {
      return Player()
    }

    let player = Player(entity: entity, insertInto: context)
    let defaultStats = DefaultPlayerStats()
    player.hp = defaultStats.hp
    player.gold = defaultStats.gold

    do {
      try context.save()
    } catch {
      print("Failed context save")
    }

    return player
  }
  
  func fetchPlayers() -> [Player] {
      let context = CoreDataManager.shared.context
      let request: NSFetchRequest<Player> = Player.fetchRequest()
      do {
          return try context.fetch(request)
      } catch {
          print("Fetch failed: \(error)")
          return []
      }
  }
  
}
