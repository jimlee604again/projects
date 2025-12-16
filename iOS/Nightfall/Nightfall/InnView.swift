//
//  InnView.swift
//  Nightfall
//
//  Created by Jimmy Lee on 12/16/25.
//

import SwiftUI

struct InnView: View {
  
  private var player: Player
  private var healAmount = 10
  private var stayCost = 1
  @State private var stayed = false
  @Environment(\.dismiss) private var dismiss
  
  init(player: Player) {
    self.player = player
  }
  var body: some View {
    VStack {
      if stayed {
        Text(
          "You stay for the night and wake up feeling refreshed. Healed 10 hp."
        )
        .multilineTextAlignment(.center)
        leaveInnButton()
      } else if player.gold < stayCost {
        Text("It seems you cannot afford to stay with us.")
        leaveInnButton()
      } else {
        Text("Welcome to the inn! \(stayCost) gold per night.")
        Button {
          stayed = true
          player.gold -= 1
          player.hp += healAmount
        } label: {
          Text("Pay \(stayCost) gold")
        }
      }
    }
  }

  func leaveInnButton() -> some View {
    return Button {
      dismiss()
    } label: {
      Text("Leave Inn")
    }
  }
}

#Preview {
  InnView(player: Player(hp: 10, gold: 3, potionCount: 0))
}
