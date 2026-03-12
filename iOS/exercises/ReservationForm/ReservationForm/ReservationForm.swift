//
//  ReservationForm.swift
//  ReservationForm
//
//  Created by Jimmy Lee on 11/21/25.
//

import SwiftUI

struct ReservationForm: View {
  @State var customerName :String = ""
  
    var body: some View {
      Form {
        TextField("Type Your Name",
                  text: $customerName,
                  onEditingChanged: { status in
          print(status)
        })
          .onChange(of: customerName, initial: false, { oldValue, newValue in
            print(newValue)
          })
          .onSubmit {
            print("submitted")
          }
      }
    }
}

#Preview {
    ReservationForm()
}
