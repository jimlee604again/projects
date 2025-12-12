//
//  ContentView.swift
//  ToDoListSwiftUI3
//
//  Created by Jimmy Lee on 12/1/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
  private static var defaultItemName = "New Item"
  private static var addItemText = "Add Item"
  @Environment(\.modelContext) private var modelContext
  @Environment(\.colorScheme) private var colorScheme
  @Query(sort: \Item.completed) private var items: [Item]
  @State private var newItemEntry: String = defaultItemName
  @State private var showingAlert = false

  var body: some View {
    NavigationView {
      List {
        ForEach(items) { item in
//          HStack {
//            Image(
//              systemName: item.completed ? "checkmark.circle.fill" : "circle"
//            )
//            Text(item.name)
//              .foregroundStyle(colorScheme == .light ? .black : .white)
//          }
//          .background(
//            NavigationLink(
//              "",
//              destination: ItemDetailView(
//                item: item,
//                saveAction: didTapSave,
//                deleteAction: didTapDelete
//              )
//            )
//            .opacity(0)
//          )

                    NavigationLink {
                      ItemDetailView(item: item,
                                     saveAction: didTapSave,
                                     deleteAction: didTapDelete)
                    } label: {
                      Button {
                      } label: {
                        HStack {
                          Image(systemName: item.completed ? "checkmark.circle.fill" : "circle")
                          Text(item.name)
                            .foregroundStyle(colorScheme == .light ? .black : .white)
                        }
                      }
                    }
        }
        .onDelete(perform: deleteItems)
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          EditButton()
        }
        ToolbarItem {
          Button(action: didTapAddItemButton) {
            Label(ContentView.addItemText, systemImage: "plus")
          }
        }
      }
      .alert(ContentView.addItemText, isPresented: $showingAlert) {
        TextField(ContentView.defaultItemName, text: $newItemEntry)

        Button {
          let newItem = Item(name: newItemEntry, completed: false)
          modelContext.insert(newItem)
          modelSave()
          newItemEntry = ContentView.defaultItemName
        } label: {
          Text("Save")
        }
      }
    }
  }

  private func didTapDelete(item: Item) {
    withAnimation {
      modelContext.delete(item)
      modelSave()
    }
  }
  
  private func didTapSave() {
    modelSave()
  }

  private func didTapAddItemButton() {
    showingAlert.toggle()
  }

  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        modelContext.delete(items[index])
        modelSave()
      }
    }
  }
  
  private func modelSave() {
    do {
      try modelContext.save()
    } catch {
      print("Failed to save context: \(error)")
    }
  }
  
}

#Preview {
  ContentView()
    .modelContainer(for: Item.self, inMemory: true)
}
