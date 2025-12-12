//
//  Item.swift
//  ToDoListSwiftUITest2
//
//  Created by Jimmy Lee on 12/8/25.
//

import Foundation
import SwiftData

@Model
final class Item {
  var name: String

  init(name: String) {
    self.name = name
  }
}
