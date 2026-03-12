//
//  ReservationCalendar.swift
//  LittleLemonDatePicker
//
//  Created by Jimmy Lee on 11/24/25.
//

import SwiftUI

struct ReservationCalendar: View {
  @State var selectedDate = Date()
  @State var displayDate = Date()
  
    var body: some View {
      Form {
        VStack {
          Text("Chosen date: " + displayDate.formatted(date: .long, time: .complete))
          HStack {
            DatePicker (
              "Please enter a date and time",
              selection: $selectedDate in Date()...,
              displayedComponents: [.date, .hourAndMinute]
            )
            Button {
              displayDate = selectedDate
            } label: {
              Label("Done", systemImage: "trash")
            }
            
          }
        }
      }
    }
}

#Preview {
    ReservationCalendar()
}
