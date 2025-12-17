//
//  BattleView.swift
//  Nightfall
//
//  Created by Jimmy Lee on 12/16/25.
//

import SwiftUI

struct BattleView: View {

  @Environment(\.dismiss) private var dismiss
  private let hpLoss = 5
  private let goldGain = 8
  private let player : Player
  @State private var died = false
  @State private var won = false

  init(player: Player) {
    self.player = player
  }
  
  var body: some View {
    ZStack {
      Image("battle")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()
      VStack {
        Spacer()
        if (died) {
          Text("You have died.")
        } else if (won) {
          Text("You emerge victorious.\nWould you like to fight again?\nYou will lose \(hpLoss) hp and gain \(goldGain) gold.")
            .multilineTextAlignment(.center)
        } else {
          Text("Would you like to battle?\nYou will lose \(hpLoss) hp and gain \(goldGain) gold.")
            .multilineTextAlignment(.center)
        }
        Spacer()
        Spacer()
        VStack {
          Text("HP: \(player.hp)")
            .foregroundStyle(.red)
          Text("Gold: \(player.gold)")
            .foregroundStyle(.yellow)
        }
        .padding()
        .background(.black)
        Spacer()
          .frame(height: 100)
      }
      if !died {
        VStack {
          Button {
            player.hp -= hpLoss
            if player.hp <= 0 {
              died = true
            } else {
              player.gold += goldGain
              won = true
            }
          } label: {
            Text("Battle")
          }
          .padding()
          .background(Color.white)
          .clipShape(.capsule)
          .padding()
          Button {
            dismiss()
          } label: {
            Text("Return")
          }
          .foregroundStyle(.red)
          .padding()
          .background(Color.white)
          .clipShape(.capsule)
          .padding()
        }
      }
    }
  }
}

#Preview {
  BattleView(player: Player(hp: 10, gold: 0, potionCount: 0))
}
