//
//  ShopView.swift
//  Nightfall
//
//  Created by Jimmy Lee on 12/14/25.
//

import SwiftUI

struct ShopView: View {
  @StateObject private var shopViewModel: ShopViewModel

  init(shopViewModel: ShopViewModel) {
    _shopViewModel = StateObject(wrappedValue: shopViewModel)
  }

  var body: some View {
    VStack {
      Spacer()
      if shopViewModel.boughtPotion {
        Text(shopViewModel.boughtPotionText)
      }
      if shopViewModel.canPlayerAffordPotion() {
        Button {
          shopViewModel.buyPotion()
        } label: {
          Text(shopViewModel.buyPotionText)
        }
      } else {
        shopViewModel.boughtPotion
          ? Text(shopViewModel.notEnoughForAnotherPotionText)
          : Text(shopViewModel.notEnoughForPotionText)
      }
    }
    Spacer()
    HStack {
      Spacer()
      Text(shopViewModel.remainingGoldText)
        .padding(.trailing, 20)
    }
  }
}

#Preview {
  ShopView(
    shopViewModel: ShopViewModel(
      player: Player(hp: 10, gold: 20, potionCount: 1)
    )
  )
}
