//
//  ItemsView.swift
//  Nightfall
//
//  Created by Jimmy Lee on 12/14/25.
//

import SwiftUI

struct ItemsView: View {
  @State private var player : Player // or binding??
  private var potionBoostValue = 10
  
  init(player: Player) {
    self.player = player
  }
  
    var body: some View {
      VStack {
        Text("Potions remaining: \(player.potionCount)")
        if player.potionCount > 0 {
          Button {
            player.potionCount -= 1
            player.hp += potionBoostValue
          } label: {
            Text("Use Potion")
          }
        }
      }
    }
}

#Preview {
    ItemsView(player: Player(hp: 10, gold: 7, potionCount: 2))
}
