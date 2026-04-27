//
//  SimpleAPIClient.swift
//  ShopApp
//
//  Created by Codex on 3/25/26.
//

import Foundation

protocol SimpleAPIClientProtocol {
    func request<T: Decodable>(urlString: String, decoder: JSONDecoder) async throws -> T
}

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

struct SimpleAPIClient: SimpleAPIClientProtocol {

    private let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func request<T: Decodable>(urlString: String, decoder: JSONDecoder = JSONDecoder()) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }

        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard 200..<300 ~= httpResponse.statusCode else {
            throw APIError.unsuccessfulStatusCode(httpResponse.statusCode)
        }

        return try decoder.decode(T.self, from: data)
    }
}
