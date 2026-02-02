//
//  WinnersView.swift
//  Nightfall
//
//  Created by Jimmy Lee on 2/1/26.
//

import SwiftData
import SwiftUI

struct WinnersView: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var winners: [Winner]

  var body: some View {
      VStack (spacing: 10) {
        Text("Winners")
        List(winners, id: \.self) { winner in
          Text(winner.name)
        }
      }.task {
        print(winners)
      }
    }
}

#Preview {
    WinnersView()
}
