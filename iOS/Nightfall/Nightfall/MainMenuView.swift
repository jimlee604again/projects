//
//  MainMenuView.swift
//  Nightfall
//
//  Created by Jimmy Lee on 12/12/25.
//

import SwiftUI

struct MainMenuView: View {

  var body: some View {
    NavigationStack {
      VStack {
        Spacer()
          .frame(maxWidth: .infinity, maxHeight: 100.0)
        Text("Main Menu")
          .font(.largeTitle)
          .foregroundStyle(.white)
        Spacer()
        NavigationLink {
          Text("Inn")
        } label: {
          Text("Inn")
            .font(.largeTitle)
            .padding()
            .background(Color.orange)
            .foregroundStyle(.black)
            .cornerRadius(8)
        }
        NavigationLink {
          Text("Shop")
        } label: {
          Text("Shop")
            .font(.largeTitle)
            .padding()
            .background(Color.orange)
            .foregroundStyle(.black)
            .cornerRadius(8)
        }
        NavigationLink {
          Text("Items")
        } label: {
          Text("Items")
            .font(.largeTitle)
            .padding()
            .background(Color.orange)
            .foregroundStyle(.black)
            .cornerRadius(8)
        }
        NavigationLink {
          Text("Battle")
        } label: {
          Text("Battle")
            .font(.largeTitle)
            .padding()
            .background(Color.orange)
            .foregroundStyle(.black)
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
