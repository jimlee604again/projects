//
//  MainMenuView.swift
//  Nightfall
//
//  Created by Jimmy Lee on 12/12/25.
//

import SwiftUI

struct MainMenuView: View {

  private let buttonCornerRadius = 8.0
  private var player: Player
  private let hpUp = 10
  private let maxHp = 50
  private let hpDown = 5
  private let goldUp = 7
  private let maxGold = 50
  private let goldDown = 6
  @State private var boughtItem = false

  init(player: Player) {
    self.player = player
  }

  var body: some View {
    NavigationStack {
      VStack {
        Spacer()
          .frame(maxWidth: .infinity, maxHeight: 60)
        Text("Main Menu")
          .font(.largeTitle)
          .foregroundStyle(.white)
        Spacer()
          .frame(height: 60)
        NavigationLink {
          Group {
            if player.hp < maxHp {
              Text("You visit the Inn and heal some")
            } else {
              Text("You are fully rested")
            }
          }
          .task {
            player.hp = min(maxHp, player.hp + hpUp)
          }
        } label: {
          MainMenuTextView("Inn")
        }
        NavigationLink {
          Group {
            if boughtItem {
              Text("You spend \(goldDown) gold on a potion.")
            } else {
              Text("You cannot afford a potion.")
            }
          }
          .task {
            boughtItem = false
            if player.gold > goldDown {
              player.gold -= goldDown
              player.potionCount += 1
              boughtItem = true
            }
          }
        } label: {
          MainMenuTextView("Shop")
        }
        NavigationLink {
          ItemsView(player: player)
        } label: {
          MainMenuTextView("Items")
        }
        NavigationLink {
          VStack {
            Text("You battle and lose some health")
            if player.hp == 0 {
              Text("You died.")
            } else {
              if player.gold + goldUp >= 50 {
                Text("Your pockets are full.")
              } else {
                Text("You earn some gold.")
              }
            }
          }
          .task {
            player.hp = max(0, player.hp - hpDown)
            player.gold = min(maxGold, player.gold + goldUp)
          }
        } label: {
          MainMenuTextView("Battle")
        }
        Spacer()
        HStack {
          AttributeTextView("HP: \(player.hp)")
            .foregroundStyle(.red)
            .fixedSize(horizontal: true, vertical: false)
          Spacer()
          AttributeTextView("Gold: \(player.gold)")
            .foregroundStyle(.yellow)
            .fixedSize(horizontal: true, vertical: false)
        }
      }
      .background(Color.black)
      .task {
        if player.hp == 0 {
          player.hp = 10
          player.gold = 0
          player.potionCount = 0
        }
      }
    }
  }

  private func MainMenuTextView(_ name: String) -> some View {
    return Text(name)
      .font(.largeTitle)
      .foregroundStyle(.black)
      .frame(maxWidth: .infinity)
      .padding()
      .background(Color.orange)
      .cornerRadius(buttonCornerRadius)
      .padding()
  }
}

private func AttributeTextView(_ name: String) -> some View {
  return Text(name)
    .font(.system(size: 40, weight: .bold, design: .default))
    .bold()
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(20)
}

#Preview {
  MainMenuView(player: Player(hp: 10, gold: 50, potionCount: 2))
}
