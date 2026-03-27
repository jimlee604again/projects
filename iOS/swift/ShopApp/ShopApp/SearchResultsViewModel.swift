//
//  SearchResultsViewModel.swift
//  ShopApp
//
//  Created by Codex on 3/25/26.
//

import Foundation

final class SearchResultsViewModel {

    let query: String

    private let searchProductsUseCase: SearchProductsUseCaseProtocol

    init(query: String, searchProductsUseCase: SearchProductsUseCaseProtocol) {
        self.query = query
        self.searchProductsUseCase = searchProductsUseCase
    }

    func loadResults() async throws -> [Product] {
        try await searchProductsUseCase.execute(query: query)
    }
}
