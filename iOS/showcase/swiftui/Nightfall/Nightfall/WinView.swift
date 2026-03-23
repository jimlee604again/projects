//
//  WinView.swift
//  Nightfall
//
//  Created by Jimmy Lee on 1/30/26.
//

import SwiftData
import SwiftUI

struct WinView: View {
  @Environment(\.modelContext) private var modelContext
  @Environment(\.dismiss) private var dismiss
  @Query private var winners: [Winner]
  @State private var name: String = "";
  @State private var isPresented = false
  
  var body: some View {
    NavigationStack {
      VStack (spacing: 16) {
        Text("You Win!")
          .padding()
        Form {
          TextField("Name", text: $name)
          Button {
            print(name)
            // save to list of players won
            modelContext.insert(Winner(name: name))
            do {
              // fix: more model context.save
              try modelContext.save()
            } catch {
              print("Couldn't save winner model.")
            }
            isPresented = true
          } label: {
            Text("Submit")
          }
        }
        .frame(maxHeight: 180)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity) // Expand VStack to fill screen
      .background(Color.teal) // Apply the background
      .ignoresSafeArea() // Extend the background into the safe areas
    }
    .navigationDestination(isPresented: $isPresented) {
      WinnersView()
    }
  }
}

#Preview {
  WinView()
}
