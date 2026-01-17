//
//  ContentView.swift
//  SearchAndFilterExample
//
//  Created by Jimmy Lee on 1/2/26.
//

import SwiftData
import SwiftUI

struct ContentView: View {
  @Environment(\.modelContext) private var modelContext
  private var items: [Item] = [
    Item(name: "abc"),
    Item(name: "bcd"),
    Item(name: "cde"),
    Item(name: "def"),
    Item(name: "efg"),
  ]
  @State private var searchTerm = ""

  var filteredItems: [Item] {
    guard !searchTerm.isEmpty else { return items }
    return items.filter { $0.name.localizedCaseInsensitiveContains(searchTerm) }
  }

  var body: some View {
    NavigationStack {
      List(filteredItems, id: \.id) { item in
        Text(item.name)
      }
      .searchable(text: $searchTerm, prompt: "Search the List")
    }
  }
}

#Preview {
  ContentView()
    .modelContainer(for: Item.self, inMemory: true)
}
