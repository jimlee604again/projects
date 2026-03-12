//
//  TabView.swift
//  NavigationExercise
//
//  Created by Jimmy Lee on 11/26/25.
//

import SwiftUI

struct MyTabView: View {
    var body: some View {
      VStack {
        TabView {
          Text("Tab1")
            .tabItem({
              Label("One", systemImage:"house")
            })
          Text("Tab2")
            .tabItem({
              Label("Two", systemImage: "menucard")
            })
        }
      }
    }
}

#Preview {
    MyTabView()
}
