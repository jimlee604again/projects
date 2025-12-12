//
//  Item.swift
//  SwiftUIData
//
//  Created by Jimmy Lee on 12/8/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
