//
//  ContentView.swift
//  Nightfall
//
//  Created by Jimmy Lee on 12/11/25.
//

import SwiftUI

struct TitleView: View {

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
        NavigationLink {
          MainMenuView()
            .navigationBarBackButtonHidden(true)
        } label: {
          Text("Start Game")
            .font(.largeTitle)
            .padding()
            .background(Color.blue)
            .foregroundStyle(.white)
            .cornerRadius(8)
        }
        Spacer()
          .frame(height: 200.0)
      }
      .background(Color.black)
    }
  }

}

#Preview {
  TitleView()
}
