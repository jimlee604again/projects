//
//  ShopAppTests.swift
//  ShopAppTests
//
//  Created by Jimmy Lee on 3/25/26.
//

import Testing
import Foundation
@testable import ShopApp

@MainActor
struct ShopAppTests {

    @Test func searchProductsUseCaseTrimsWhitespaceBeforeQueryingRepository() async throws {
        let repository = ProductRepositorySpy()
        let useCase = SearchProductsUseCase(repository: repository)

        _ = try await useCase.execute(query: "  shoes  ")

        #expect(repository.receivedQuery == "shoes")
    }

    @Test func searchResultsViewModelLoadsResultsFromUseCase() async throws {
        let expectedProducts = [
            Product(id: UUID(), name: "Running Shoes", imageSystemName: "figure.run")
        ]
        let useCase = SearchProductsUseCaseSpy(productsToReturn: expectedProducts)
        let viewModel = SearchResultsViewModel(query: "shoes", searchProductsUseCase: useCase)

        let products = try await viewModel.loadResults()

        #expect(useCase.receivedQuery == "shoes")
        #expect(products == expectedProducts)
    }

    @Test func simpleAPIClientThrowsInvalidURLForMalformedString() async throws {
        let client = SimpleAPIClient()

        do {
            let _: APIClientTestResponse = try await client.request(urlString: "http://exa mple​.com")
            Issue.record("Expected invalidURL error")
        } catch APIError.invalidURL {
            // Expected path.
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }

    @Test func simpleAPIClientDecodesResponseBody() async throws {
        let session = MockURLSession(
            data: #"{"message":"ok"}"#.data(using: .utf8),
            response: HTTPURLResponse(
                url: URL(string: "https://google.com")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            ),
            error: nil
        )
        let client = SimpleAPIClient(session: session)

        let response: APIClientTestResponse = try await client.request(urlString: "https://google.com")

        #expect(response.message == "ok")
    }

    @Test func simpleAPIClientThrowsOnUnsuccessfulStatusCode() async throws {
        let session = MockURLSession(
            data: Data(),
            response: HTTPURLResponse(
                url: URL(string: "https://httpbin.org/status/404")!,
                statusCode: 404,
                httpVersion: nil,
                headerFields: nil
            ),
            error: nil
        )
        let client = SimpleAPIClient(session: session)

        do {
            let _: APIClientTestResponse = try await client.request(urlString: "https://httpbin.org/status/404")
            Issue.record("Expected unsuccessfulStatusCode error")
        } catch APIError.unsuccessfulStatusCode(let statusCode) {
            #expect(statusCode == 404)
        } catch {
            Issue.record("Unexpected error: \(error)")
        }
    }

}

private final class ProductRepositorySpy: ProductRepositoryProtocol {
    var receivedQuery: String?

    func searchProducts(query: String) async throws -> [Product] {
        receivedQuery = query
        return []
    }
}

private final class SearchProductsUseCaseSpy: SearchProductsUseCaseProtocol {
    private let productsToReturn: [Product]
    var receivedQuery: String?

    init(productsToReturn: [Product]) {
        self.productsToReturn = productsToReturn
    }

    func execute(query: String) async throws -> [Product] {
        receivedQuery = query
        return productsToReturn
    }
}

private struct APIClientTestResponse: Decodable {
    let message: String
}

private struct MockURLSession: URLSessionProtocol {
    let data: Data?
    let response: URLResponse?
    let error: Error?

    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error {
            throw error
        }

        return (data ?? Data(), response ?? URLResponse())
    }
}
