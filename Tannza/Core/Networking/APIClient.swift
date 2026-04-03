//
//  APIClient.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 12/03/2026.
//
import Foundation

protocol APIClientProtocol {
    func post<T: Decodable, U: Encodable>(
        endpoint: Endpoint,
        body: U
    ) async throws -> T
}

final class APIClient: APIClientProtocol {

    private let baseURL = "https://api.delivery.herlay.com/api/v1"

    func post<T: Decodable, U: Encodable>(
        endpoint: Endpoint,
        body: U
    ) async throws -> T {

        guard let url = URL(string: baseURL + endpoint.path) else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        print(data, "data........")
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}

