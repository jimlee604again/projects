//
//  InnView.swift
//  Nightfall
//
//  Created by Jimmy Lee on 12/16/25.
//

import SwiftUI

struct InnView: View {
  @StateObject private var innViewModel : InnViewModel
  @Environment(\.dismiss) var dismiss
  
  init(innViewModel: InnViewModel) {
    _innViewModel = StateObject(wrappedValue: innViewModel)
  }

  var body: some View {
    ZStack {
      Image(innViewModel.backgroundImageFileName)
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()
      VStack {
        Spacer()
        VStack {
          if innViewModel.stayed {
            Text(innViewModel.stayedText)
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            leaveInnButton()
          } else if !innViewModel.canPlayerAffordInn() {
            Text(innViewModel.cantAffordText)
              .foregroundStyle(.white)
            leaveInnButton()
          } else {
            Text(innViewModel.welcomeText())
              .foregroundStyle(.white)
            Button {
                innViewModel.invokePlayerStaysAtInn()
            } label: {
              Text(innViewModel.payGoldText())
                .padding()
                .cornerRadius(4)
                .border(Color.blue, width: 2)
            }
          }
          Text(innViewModel.remainingGoldText())
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
      Text(innViewModel.leaveText)
        .padding()
        .cornerRadius(4)
        .border(Color.blue, width: 2)
    }
  }
}

#Preview {
  InnView(innViewModel: InnViewModel(player: Player(hp: 10, gold: 3, potionCount: 0)))
}
