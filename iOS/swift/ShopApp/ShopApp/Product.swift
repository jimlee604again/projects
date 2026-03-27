//
//  Product.swift
//  ShopApp
//
//  Created by Codex on 3/25/26.
//

import Foundation

struct Product: Identifiable, Equatable {
    let id: UUID
    let name: String
    let imageSystemName: String
}
