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
          InnView(innViewModel: InnViewModel(player: player))
        } label: {
          MainMenuTextView("Inn")
        }
        NavigationLink {
          ShopView(shopViewModel: ShopViewModel(player: player))
        } label: {
          MainMenuTextView("Shop")
        }
        NavigationLink {
          ItemsView(itemsViewModel: ItemsViewModel(player: player))
        } label: {
          MainMenuTextView("Items")
        }
        NavigationLink {
          BattleView(player: player)
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
        if player.hp <= 0 {
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
      .background(Color.mint)
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
