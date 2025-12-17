//
//  ContentView.swift
//  Nightfall
//
//  Created by Jimmy Lee on 12/11/25.
//

import SwiftData

import SwiftUI

struct TitleView: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var players: [Player]
  
  init() {
    UINavigationBar.setAnimationsEnabled(false)
  }
  
  var body: some View {
    NavigationStack {
      VStack {
        Spacer()
          .frame(maxWidth: .infinity, maxHeight: 100.0)
        Text("Nightfall")
          .font(.largeTitle)
          .foregroundStyle(.white)
        Spacer()
        if (players.first != nil) {
          NavigationLink {
            MainMenuView(player: players.first!)
              .navigationBarBackButtonHidden(true)
          } label: {
            Text("Start Game")
              .font(.largeTitle)
              .padding()
              .background(Color.blue)
              .foregroundStyle(.white)
              .cornerRadius(8)
          }
        }
        Spacer()
          .frame(height: 200.0)
      }
      .background(Color.black)
    }
    .task {
      if (players.first == nil) {
        modelContext.insert(Player(hp: 10, gold: 0, potionCount: 0))
        do {
          try modelContext.save()
        } catch {
          print("Couldn't save player model.")
        }
      }
    }
}

}

#Preview {
  TitleView()
}
