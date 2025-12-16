//
//  ShopView.swift
//  Nightfall
//
//  Created by Jimmy Lee on 12/14/25.
//

import SwiftUI

struct ShopView: View {
  private let player : Player
  private let potionPrice = 6
  @State var boughtPotion = false
  
  init(player: Player) {
    self.player = player
  }
  
  var body: some View {
    VStack {
      Spacer()
      if boughtPotion {
        Text("You bought a potion.")
      }
      if player.gold >= potionPrice {
        Button {
          player.gold -= potionPrice
          player.potionCount += 1
          boughtPotion = true
        } label: {
          Text("Buy Potion")
        }
      } else {
        if !boughtPotion {
          Text("You don't have enough gold.")
        }
      }
      Spacer()
      HStack {
        Spacer()
        Text("Gold: \(player.gold)")
          .padding(.trailing, 20)
      }
    }
  }
}

#Preview {
  ShopView(player: Player(hp: 10, gold: 20, potionCount: 1))
}
