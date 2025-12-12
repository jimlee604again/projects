//
//  SwiftUIView.swift
//  ToDoListSwiftUI3
//
//  Created by Jimmy Lee on 12/2/25.
//

import SwiftUI

struct ItemDetailView: View {
  @Environment(\.dismiss) private var dismiss
  @State var item: Item
  @State var text: String
  let deleteAction: (Item) -> Void
  let saveAction: () -> Void

  init(item: Item,
       saveAction: @escaping () -> Void,
       deleteAction: @escaping (Item) -> Void) {
    self.item = item
    self.text = item.name
    self.saveAction = saveAction
    self.deleteAction = deleteAction
  }

  var body: some View {
    VStack {
      Form {
        TextField("", text: $text)
      }
      VStack(spacing: 20) {
        Button {
          item.name = text
          saveAction()
          dismiss()
        } label: {
          Text("Save Item Name")
            .frame(maxWidth: .infinity)
        }
        Button {
          item.completed.toggle()
          dismiss()
        } label: {
          Text(item.completed ? "Mark Incomplete" : "Mark Complete")
            .frame(maxWidth: .infinity)
        }
        Button {
          dismiss()
        } label: {
          Text("Cancel")
            .frame(maxWidth: .infinity)
        }
        Button {
          deleteAction(self.item)
          dismiss()
        } label: {
          Text("Delete")
            .frame(maxWidth: .infinity)
            .tint(.red)
        }
      }
    }
  }
}
