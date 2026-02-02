//
//  BattleView.swift
//  Nightfall
//
//  Created by Jimmy Lee on 12/16/25.
//

import SwiftUI

struct BattleView: View {

  @Environment(\.dismiss) private var dismiss
  
  @StateObject private var battleViewModel: BattleViewModel;
  
  init(battleViewModel: BattleViewModel) {
    _battleViewModel = StateObject(wrappedValue: battleViewModel)
  }
  
  // fix: not fully migrated
  var body: some View {
    ZStack {
      Image(battleViewModel.backgroundImageFileName)
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()
      VStack {
        Spacer()
        if (battleViewModel.playerDied) {
          Text(battleViewModel.playerDiedText)
        } else if (battleViewModel.playerWon) {
          Text(battleViewModel.playerWonText())
            .multilineTextAlignment(.center)
        } else {
          Text(battleViewModel.askToBattleText())
            .multilineTextAlignment(.center)
        }
        Spacer()
        Spacer()
        VStack {
          Text(battleViewModel.remainingHPText())
            .foregroundStyle(.red)
          Text(battleViewModel.remainingGoldText())
            .foregroundStyle(.yellow)
        }
        .padding()
        .background(.black)
        Spacer()
          .frame(height: 100)
      }
      if !(battleViewModel.playerDied) {
        VStack {
          Button {
            battleViewModel.resolveBattle()
          } label: {
            Text(battleViewModel.battleButtonText)
          }
          .padding()
          .background(Color.white)
          .clipShape(.capsule)
          .padding()
          Button {
            dismiss()
          } label: {
            Text(battleViewModel.returnButtonText)
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
  BattleView(battleViewModel: BattleViewModel(player: Player(hp: 10, gold: 0, potionCount: 0)))
}
