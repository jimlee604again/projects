//
//  ViewController.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 1/20/26.
//

import CoreData
import UIKit
import Foundation

class TitleViewController: UIViewController, StartButtonDelegate {
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    self.view = TitleView(startButtonDelegate: self)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  func didTapStart() {
    let player = createPlayer()
    let mainMenuVC = MainMenuViewController(player: player)
    mainMenuVC.modalPresentationStyle = .fullScreen
    present(mainMenuVC, animated: false)
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

  
  func createPlayer() -> Player {
    let context = CoreDataManager.shared.context
    let players = fetchPlayers()
    
    if let existing = players.first {
      return existing
    }
    
    // generate base player if a persisted one isn't fetched
    guard let entity = NSEntityDescription.entity(
      forEntityName: "Player",
      in: context
    ) else {
      return Player()
    }
    
    let player = Player(entity: entity, insertInto: context)
    player.hp = 10
    player.gold = 0
    
    do {
      try context.save()
    } catch {
      print("Failed context save")
    }

    return player
  }
}

