//
//  MainMenuView.swift
//  Nightfall
//
//  Created by Jimmy Lee on 12/12/25.
//

import SwiftUI

struct MainMenuView: View {

  private let buttonCornerRadius = 8.0
  @StateObject private var mainMenuViewModel: MainMenuViewModel;

  init(mainMenuViewModel: MainMenuViewModel) {
    _mainMenuViewModel = StateObject(wrappedValue: mainMenuViewModel)
  }
  
  // fix: add more bg images
  var body: some View {
    NavigationStack {
      VStack {
        Spacer()
          .frame(maxWidth: .infinity, maxHeight: 60)
        Text(mainMenuViewModel.mainMenuTitle)
          .font(.largeTitle)
          .foregroundStyle(.white)
        Spacer()
          .frame(height: 60)
        NavigationLink {
          InnView(innViewModel: InnViewModel(player: mainMenuViewModel.player))
        } label: {
          MainMenuTextView(mainMenuViewModel.innTitle)
        }
        NavigationLink {
          ShopView(shopViewModel: ShopViewModel(player: mainMenuViewModel.player))
        } label: {
          MainMenuTextView(mainMenuViewModel.shopTitle)
        }
        NavigationLink {
          ItemsView(itemsViewModel: ItemsViewModel(player: mainMenuViewModel.player))
        } label: {
          MainMenuTextView(mainMenuViewModel.itemsTitle)
        }
        NavigationLink {
          BattleView(battleViewModel: BattleViewModel(player: mainMenuViewModel.player))
        } label: {
          MainMenuTextView(mainMenuViewModel.battleTitle)
        }
        Spacer()
        HStack {
          AttributeTextView(mainMenuViewModel.playerHP())
            .foregroundStyle(.red)
            .fixedSize(horizontal: true, vertical: false)
          Spacer()
          AttributeTextView(mainMenuViewModel.playerGold())
            .foregroundStyle(.yellow)
            .fixedSize(horizontal: true, vertical: false)
        }
      }
      .background(Color.black)
      .task {
        mainMenuViewModel.handlePlayerDeath()
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
  MainMenuView(mainMenuViewModel: MainMenuViewModel(player: Player(hp: 10, gold: 50, potionCount: 2)))
}
