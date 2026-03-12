//
//  ItemsView.swift
//  Nightfall
//
//  Created by Jimmy Lee on 12/14/25.
//

import SwiftUI

struct ItemsView: View {
  @StateObject private var itemsViewModel: ItemsViewModel

  init(itemsViewModel: ItemsViewModel) {
    _itemsViewModel = StateObject(wrappedValue: itemsViewModel)
  }

  var body: some View {
    VStack {
      Text(itemsViewModel.potionsRemainingText())
      if itemsViewModel.playerHasPotions() {
        Button {
          itemsViewModel.playerUsedPotion()
        } label: {
          Text(itemsViewModel.usePotionText)
        }
      }
    }
  }
}

#Preview {
  ItemsView(itemsViewModel: ItemsViewModel(player: Player(hp: 10, gold: 7, potionCount: 2)))
}
