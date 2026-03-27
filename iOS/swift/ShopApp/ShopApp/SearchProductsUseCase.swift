//
//  SearchProductsUseCase.swift
//  ShopApp
//
//  Created by Codex on 3/25/26.
//

import Foundation

protocol SearchProductsUseCaseProtocol {
    func execute(query: String) async throws -> [Product]
}

final class SearchProductsUseCase: SearchProductsUseCaseProtocol {

    private let repository: ProductRepositoryProtocol

    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }

    func execute(query: String) async throws -> [Product] {
        let normalizedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        return try await repository.searchProducts(query: normalizedQuery)
    }
}
