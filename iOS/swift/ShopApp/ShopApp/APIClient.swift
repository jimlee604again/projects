//
//  APIClient.swift
//  ShopApp
//
//  Created by Codex on 3/25/26.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case unsuccessfulStatusCode(Int)
}

struct Endpoint {
    let scheme: String
    let host: String
    let path: String
    let method: HTTPMethod
    let queryItems: [URLQueryItem]
    let headers: [String: String]

    init(
        scheme: String = "https",
        host: String,
        path: String,
        method: HTTPMethod = .get,
        queryItems: [URLQueryItem] = [],
        headers: [String: String] = [:]
    ) {
        self.scheme = scheme
        self.host = host
        self.path = path
        self.method = method
        self.queryItems = queryItems
        self.headers = headers
    }

    func urlRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems.isEmpty ? nil : queryItems

        guard let url = components.url else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        return request
    }
}

protocol APIClientProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint, decoder: JSONDecoder) async throws -> T
}

struct APIClient: APIClientProtocol {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func request<T: Decodable>(_ endpoint: Endpoint, decoder: JSONDecoder = JSONDecoder()) async throws -> T {
        let request = try endpoint.urlRequest()
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard 200..<300 ~= httpResponse.statusCode else {
            throw APIError.unsuccessfulStatusCode(httpResponse.statusCode)
        }

        return try decoder.decode(T.self, from: data)
    }
}
