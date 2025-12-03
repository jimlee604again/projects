//
//  Item.swift
//  ToDoListSwiftUI3
//
//  Created by Jimmy Lee on 12/1/25.
//

import SwiftData
import Observation

@Model
final class Item {
  var name: String
  var completed: Bool

  init(name: String, completed: Bool) {
    self.name = name
    self.completed = completed
  }
}

extension Bool: @retroactive Comparable {
  public static func < (lhs: Bool, rhs: Bool) -> Bool {
    !lhs && rhs
  }
}
