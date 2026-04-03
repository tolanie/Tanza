//
//  NetworkError.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 12/03/2026.
//

import Foundation

/// Represents all possible networking failures that can occur during an API call.
enum NetworkError: Error, LocalizedError {
    /// The constructed URL string was not a valid URL.
    case invalidURL

    /// The network request itself failed (e.g. no connectivity, timeout).
    /// Carries the underlying system error for diagnostics.
    case requestFailed(Error)

    /// The server returned a non-2xx HTTP status code.
    /// Carries the status code so callers can react appropriately.
    case httpError(statusCode: Int)

    /// The server response could not be decoded into the expected model.
    /// Carries the underlying decoding error for diagnostics.
    case decodingFailed(Error)

    // MARK: - LocalizedError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The request URL is invalid."
        case .requestFailed(let error):
            return "Network request failed: \(error.localizedDescription)"
        case .httpError(let statusCode):
            return "Server returned an error (HTTP \(statusCode))."
        case .decodingFailed(let error):
            return "Failed to decode server response: \(error.localizedDescription)"
        }
    }
}
