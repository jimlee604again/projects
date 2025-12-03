//
//  ContentView.swift
//  ListExercise
//
//  Created by Jimmy Lee on 11/26/25.
//

import SwiftUI
internal import Combine

struct ContentView: View {
  @ObservedObject private var model = Model(objectWillChange: ObservableObjectPublisher())

  var body: some View {
    VStack {
      List {
        ForEach(model.meals) { item in
          Text(item.name)
        }
      }
    }
  }
}

struct Item: Identifiable {
  let id = UUID()
  let name: String
}

class Model: ObservableObject {
  var objectWillChange: ObservableObjectPublisher
  
  @Published var meals: [Item] = menuItems()

  init(objectWillChange: ObservableObjectPublisher) {
    self.objectWillChange = objectWillChange
  }
  
  static func menuItems() -> [Item] {
    return [
      Item(name: "Lasagna"),
      Item(name: "Fettuccini Alfredo"),
      Item(name: "Spaghetti"),
      Item(name: "Avocado Toast"),
      Item(name: "Tortellini"),
      Item(name: "Pizza"),
    ]
  }
}

#Preview {
  ContentView()
}
