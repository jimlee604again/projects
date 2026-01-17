//
//  Item.swift
//  SearchAndFilterExample
//
//  Created by Jimmy Lee on 1/2/26.
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
