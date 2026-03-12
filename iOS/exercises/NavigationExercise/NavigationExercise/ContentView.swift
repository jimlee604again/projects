//
//  ContentView.swift
//  NavigationExercise
//
//  Created by Jimmy Lee on 11/26/25.
//

import SwiftUI

struct ContentView: View {
  let useTabbed = true
  
  var body: some View {
    NavigationView {
      useTabbed
      ? AnyView(MyTabView())
      : AnyView(VStack {
        Image(systemName: "globe")
          .imageScale(.large)
          .foregroundStyle(.tint)
        Text("Title")
        NavigationLink("Click Me") {
          Color.blue
        }
      }
      .padding())
    }
  }
}

#Preview {
  ContentView()
}
