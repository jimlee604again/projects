//
//  ProductRepository.swift
//  ShopApp
//
//  Created by Codex on 3/25/26.
//

import Foundation

protocol ProductRepositoryProtocol {
    func searchProducts(query: String) async throws -> [Product]
}

final class RemoteProductRepository: ProductRepositoryProtocol {

    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func searchProducts(query: String) async throws -> [Product] {
        let endpoint = Endpoint(
            host: "dummyjson.com",
            path: "/products/search",
            queryItems: [URLQueryItem(name: "q", value: query)]
        )

        let response: ProductSearchResponse = try await apiClient.request(endpoint, decoder: JSONDecoder())
        let products = response.products.map { productDTO in
            Product(
                id: UUID(),
                name: productDTO.title,
                imageSystemName: "shippingbox"
            )
        }

        return Array(products.prefix(4))
    }
}

final class MockProductRepository: ProductRepositoryProtocol {

    private let products: [Product] = [
        Product(id: UUID(), name: "Travel Backpack", imageSystemName: "backpack"),
        Product(id: UUID(), name: "Running Shoes", imageSystemName: "figure.run"),
        Product(id: UUID(), name: "Coffee Mug", imageSystemName: "mug"),
        Product(id: UUID(), name: "Desk Lamp", imageSystemName: "lamp.desk"),
        Product(id: UUID(), name: "Wireless Headphones", imageSystemName: "headphones"),
        Product(id: UUID(), name: "Water Bottle", imageSystemName: "waterbottle"),
        Product(id: UUID(), name: "Weekend Tote", imageSystemName: "bag"),
        Product(id: UUID(), name: "Smart Watch", imageSystemName: "applewatch")
    ]

    func searchProducts(query: String) async throws -> [Product] {
        try await Task.sleep(nanoseconds: 300_000_000)

        guard query.isEmpty == false else {
            return Array(products.prefix(4))
        }

        let filteredProducts = products.filter { product in
            product.name.localizedCaseInsensitiveContains(query)
        }

        return Array((filteredProducts.isEmpty ? products : filteredProducts).prefix(4))
    }
}

private struct ProductSearchResponse: Decodable {
    let products: [ProductDTO]
}

private struct ProductDTO: Decodable {
    let title: String
}
