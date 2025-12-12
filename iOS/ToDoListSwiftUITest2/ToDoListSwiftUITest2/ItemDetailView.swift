//
//  ItemDetailView.swift
//  ToDoListSwiftUITest2
//
//  Created by Jimmy Lee on 12/8/25.
//

import SwiftUI

struct ItemDetailView: View {

  @State private var item: Item
  @State private var entryText: String
//  private var saveAction = () -> Void
  @Environment(\.dismiss) var dismiss

//  init(item: Item, saveAction: () -> Void) {
  init(item: Item) {
    self.item = item
    self.entryText = item.name
//    self.saveAction = saveAction
  }
  
  var body: some View {
    VStack {
      Form {
        TextField("", text: $item.name)
      }
      Button {
        item.name = entryText
//        saveAction()
        dismiss()
      } label: {
        Text("Save")
      }
      Button {
        dismiss()
      } label: {
        Text("Cancel")
      }
    }
  }
}

