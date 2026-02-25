//
//  MainMenuViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 2/24/26.
//

import Foundation

public class MainMenuViewModel {
  private let player: Player
  private var innViewModel: InnViewModel?
  
  init(player: Player) {
    self.player = player
  }
  
  func makeInnViewModel() -> InnViewModel {
    if innViewModel == nil {
      innViewModel = InnViewModel(player: player)
    }
    return innViewModel!
  }
  
  func playerHealthDisplayText() -> String {
    return "HP: \(player.hp)"
  }
  
  func playerGoldDisplayText() -> String {
    return "\(player.gold) gold"
  }
}
