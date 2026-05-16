//
//  APIClient.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 12/03/2026.
//

import Foundation
import OSLog

// MARK: - Protocol

/// Defines the contract for making HTTP requests.
/// Programming to this abstraction lets us swap in a mock client during testing.
protocol APIClientProtocol {
    /// Sends a POST request to the given endpoint, encoding `body` as JSON,
    /// and decodes the response into type `T`.
    func post<T: Decodable, U: Encodable>(
        endpoint: Endpoint,
        body: U
    ) async throws -> T

    /// Sends a GET request to the given endpoint, appending `queryParams` as
    /// URL query items if provided, and decodes the response into type `T`.
    func get<T: Decodable>(
        endpoint: Endpoint,
        queryParams: [String: String]?
    ) async throws -> T
}

// MARK: - Implementation

/// Concrete HTTP client backed by `URLSession`.
/// All requests share the same `baseURL` and send/receive JSON.
final class APIClient: APIClientProtocol {

    // MARK: - Private

    private let baseURL = "https://api.delivery.herlay.com/api/v1"
    private let session: URLSession
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "Tannza", category: "APIClient")

    // MARK: - Init

    /// - Parameter session: The URLSession to use. Defaults to `.shared` which is
    ///   suitable for production. Pass a custom session in tests to intercept traffic.
    init(session: URLSession = .shared) {
        self.session = session
    }

    // MARK: - APIClientProtocol

    func post<T: Decodable, U: Encodable>(
        endpoint: Endpoint,
        body: U
    ) async throws -> T {

        // 1. Build URL
        guard let url = URL(string: baseURL + endpoint.path) else {
            logger.error("[\(endpoint.method)] \(endpoint.path) — Invalid URL")
            throw NetworkError.invalidURL
        }

        // 2. Encode request body
        let encodedBody: Data
        do {
            encodedBody = try JSONEncoder().encode(body)
        } catch {
            // Encoding is a programmer error; re-throw as requestFailed so it surfaces clearly.
            logger.error("[\(endpoint.method)] \(endpoint.path) — Failed to encode request body: \(error)")
            throw NetworkError.requestFailed(error)
        }

        // 3. Build URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = encodedBody

        // Log the outgoing request
        logRequest(method: endpoint.method, path: endpoint.path, body: encodedBody)

        // 4. Execute request
        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await session.data(for: request)
        } catch {
            logger.error("[\(endpoint.method)] \(endpoint.path) — Request failed: \(error)")
            throw NetworkError.requestFailed(error)
        }

        // 5. Log & decode response
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
        return try decodeResponse(T.self, data: data, statusCode: statusCode, method: endpoint.method, path: endpoint.path)
    }

    func get<T: Decodable>(
        endpoint: Endpoint,
        queryParams: [String: String]? = nil
    ) async throws -> T {

        // 1. Build URL, appending query params if present
        guard var components = URLComponents(string: baseURL + endpoint.path) else {
            logger.error("[GET] \(endpoint.path) — Invalid URL")
            throw NetworkError.invalidURL
        }

        if let queryParams, !queryParams.isEmpty {
            components.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        }

        guard let url = components.url else {
            logger.error("[GET] \(endpoint.path) — Failed to construct URL with query params")
            throw NetworkError.invalidURL
        }

        // 2. Build URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Log the outgoing request (no body for GET)
        logger.debug("""
        ➡️  REQUEST  [GET] \(endpoint.path)
        Query: \(queryParams?.description ?? "none")
        """)

        // 3. Execute request
        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await session.data(for: request)
        } catch {
            logger.error("[GET] \(endpoint.path) — Request failed: \(error)")
            throw NetworkError.requestFailed(error)
        }

        // 4. Log & decode response
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
        return try decodeResponse(T.self, data: data, statusCode: statusCode, method: "GET", path: endpoint.path)
    }

    // MARK: - Shared Decode Helper

    /// Logs the response and decodes it into `T`, applying consistent fallback
    /// error logic shared by both `post` and `get`.
    private func decodeResponse<T: Decodable>(
        _ type: T.Type,
        data: Data,
        statusCode: Int,
        method: String,
        path: String
    ) throws -> T {
        logResponse(method: method, path: path, statusCode: statusCode, data: data)

        // We attempt decoding regardless of the HTTP status code because this API
        // always returns a JSON envelope ({ success, message, data }) even for
        // error responses (e.g. 404 "Invalid Otp"). Decoding first lets the view
        // model read `response.success` and `response.message` and show the
        // server's own error text to the user.
        //
        // Only if decoding itself fails do we fall back to throwing `httpError`
        // for non-2xx codes, or `decodingFailed` for 2xx codes with unreadable bodies.
        do {
//            return try JSONDecoder().decode(T.self, from: data)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch let decodingError {
            logger.error("[\(method)] \(path) — Decoding failed: \(decodingError)")

            if !(200...299).contains(statusCode) {
                throw NetworkError.httpError(statusCode: statusCode)
            }
            throw NetworkError.decodingFailed(decodingError)
        }
    }

    // MARK: - Logging Helpers

    /// Logs the outgoing request method, path, and body as a pretty-printed JSON string.
    private func logRequest(method: String, path: String, body: Data) {
        let bodyString = prettyPrinted(body) ?? String(data: body, encoding: .utf8) ?? "<unreadable>"
        logger.debug("""
        ➡️  REQUEST  [\(method)] \(path)
        Body:
        \(bodyString)
        """)
    }

    /// Logs the incoming response status code and body.
    private func logResponse(method: String, path: String, statusCode: Int, data: Data) {
        let bodyString = prettyPrinted(data) ?? String(data: data, encoding: .utf8) ?? "<unreadable>"
        logger.debug("""
        ⬅️  RESPONSE [\(method)] \(path) — HTTP \(statusCode)
        Body:
        \(bodyString)
        """)
    }

    /// Returns a pretty-printed JSON string, or `nil` if the data is not valid JSON.
    private func prettyPrinted(_ data: Data) -> String? {
        guard
            let object = try? JSONSerialization.jsonObject(with: data),
            let pretty = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted),
            let string = String(data: pretty, encoding: .utf8)
        else { return nil }
        return string
    }
}
