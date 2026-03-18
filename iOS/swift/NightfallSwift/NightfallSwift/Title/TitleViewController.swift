//
//  ViewController.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 1/20/26.
//

import CoreData
import UIKit

class TitleViewController: UIViewController, StartButtonDelegate {
  
  let titleViewModel: TitleViewModel = TitleViewModel()
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    titleView.configure(with: titleViewModel.viewState)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    let titleView = TitleView()
    titleView.startButtonDelegate = self
    view = titleView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    if let titleView = self.view as? TitleView {
      titleView.configure(with: titleViewModel.viewState)
    }
  }

  func didTapStart() {
    let mainMenuViewModel = MainMenuViewModel(gameState: GameState(player: createPlayer()))
    let mainMenuVC = MainMenuViewController(mainMenuViewModel: mainMenuViewModel)
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
    player.hp = titleViewModel.playerStartingHealth
    player.gold = titleViewModel.playerStartingGold
    
    do {
      try context.save()
    } catch {
      print("Failed context save")
    }

    return player
  }
}

