//
//  NavigationCoordinator.swift
//  ShopApp
//
//  Created by Codex on 3/25/26.
//

import UIKit

final class NavigationCoordinator {

    private weak var navigationController: UINavigationController?
    private let productRepository: ProductRepositoryProtocol

    init(
        navigationController: UINavigationController,
        productRepository: ProductRepositoryProtocol = MockProductRepository()
    ) {
        self.navigationController = navigationController
        self.productRepository = productRepository
    }

    func showSearchResults(for query: String) {
        let searchProductsUseCase = SearchProductsUseCase(repository: productRepository)
        let viewModel = SearchResultsViewModel(query: query, searchProductsUseCase: searchProductsUseCase)
        let searchResultsViewController = SearchResultsViewController(viewModel: viewModel)
        navigationController?.pushViewController(searchResultsViewController, animated: true)
    }
}
