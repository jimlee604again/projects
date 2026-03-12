//
//  MainMenuViewModel.swift
//  NightfallSwift
//
//  Created by Jimmy Lee on 2/24/26.
//

import Combine
import Foundation

public class MainMenuViewModel: ObservableObject {
  @Published private var player: Player
  private var innViewModel: InnViewModel?
  
  init(player: Player) {
    self.player = player
  }
  
  func makeInnViewModel() -> InnViewModel {
    return InnViewModel(player: player)
  }
  
  func makeShopViewModel() -> ShopViewModel {
    return ShopViewModel(player: player)
  }
  
  func makeItemsViewModel() -> ItemsViewModel {
    return ItemsViewModel(player: player)
  }
  
  func makeBattleViewModel() -> BattleViewModel {
    return BattleViewModel(player: player)
  }
  
  func completeBattle() {
    player.hp -= 3
    player.gold += 10
  }
  
  func playerHealthDisplayText() -> String {
    return "HP: \(player.hp)"
  }
  
  func playerGoldDisplayText() -> String {
    return "Gold: \(player.gold)"
  }
}
