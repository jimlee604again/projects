//
//  ContentView.swift
//  ToDoListSwiftUITest2
//
//  Created by Jimmy Lee on 12/8/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                      ItemDetailView(item: item)
                    } label: {
                      Text(item.name)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

//  private func saveItem() {
//    
//  }
  
    private func addItem() {
        withAnimation {
            let newItem = Item(name: "New Item")
            modelContext.insert(newItem)
          do {
            try modelContext.save()
          } catch {
            print("Failed to save context: \(error)")
          }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
