//
//  ContentView.swift
//  Reservations
//
//  Created by Jimmy Lee on 11/19/25.
//

import SwiftUI

struct ContentView: View {
    @State var personCount: Int = 1
    
    var body: some View {
        VStack {
            Text("Little Lemon")
            Stepper {
                Text("Reservation for: \(personCount)")
            } onIncrement: {
                personCount += 1
            } onDecrement: {
                personCount = (personCount == 1) ? 1 : personCount - 1
            }
        }
        .padding()
    }
}

#Preview {
    ContentView(personCount: 5)
}
