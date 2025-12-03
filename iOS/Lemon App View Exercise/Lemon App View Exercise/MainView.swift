//
//  MainView.swift
//  Lemon App View Exercise
//
//  Created by Jimmy Lee on 11/22/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
      ZStack {
        HStack {
          Text("Demo")
            .frame(width: 100, height: 100, alignment: .center)
          VStack (spacing: 100) {
            Text("Tomato Tortellini, Bottarga and Carbonara")
              .multilineTextAlignment(.center)
          }
        }
        .padding()
      }
      .background(.red)
    }
}

#Preview {
    MainView()
}
