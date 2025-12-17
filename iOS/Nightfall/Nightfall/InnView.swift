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
  private var stayCost = 2
  @State private var stayed = false
  @Environment(\.dismiss) private var dismiss
  
  init(player: Player) {
    self.player = player
  }

  var body: some View {
    ZStack {
      Image("inn")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()
      VStack {
        Spacer()
        VStack {
          if stayed {
            Text(
              "You stay for the night and wake up feeling refreshed. Healed 10 hp."
            )
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            leaveInnButton()
          } else if player.gold < stayCost {
            Text("It seems you cannot afford to stay with us.")
              .foregroundStyle(.white)
            leaveInnButton()
          } else {
            Text("Welcome to the inn! \(stayCost) gold per night.")
              .foregroundStyle(.white)
            Button {
              stayed = true
              player.gold -= stayCost
              player.hp += healAmount
            } label: {
              Text("Pay \(stayCost) gold")
                .padding()
                .cornerRadius(4)
                .border(Color.blue, width: 2)
            }
          }
          Text("Gold: \(player.gold)")
            .foregroundStyle(.yellow)
        }
        .padding()
        .background(.black)
        .padding()
      }
    }
  }

  func leaveInnButton() -> some View {
    return Button {
      dismiss()
    } label: {
      Text("Leave Inn")
        .padding()
        .cornerRadius(4)
        .border(Color.blue, width: 2)
    }
  }
}

#Preview {
  InnView(player: Player(hp: 10, gold: 3, potionCount: 0))
}
