//
//  AuthService.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 12/03/2026.
//

import Foundation

/// Concrete implementation of `AuthServiceProtocol`.
/// Delegates all network traffic to the injected `APIClientProtocol`,
/// keeping authentication logic decoupled from the raw HTTP layer.
final class AuthService: AuthServiceProtocol {
    private let apiClient: APIClientProtocol

    // MARK: - Init

    /// - Parameter apiClient: The HTTP client used to make API calls.
    ///   Inject `APIClient()` in production and a mock in tests.
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    // MARK: - AuthServiceProtocol

    /// Calls `POST /otp` to trigger an OTP SMS to the provided phone number.
    func sendOtp(request: OTPRequest) async throws -> OTPResponse {
        return try await apiClient.post(
            endpoint: .otp,
            body: request
        )
    }

    /// Calls `POST /otp/consume` to verify the OTP code entered by the user.
    func sendOtpConsume(request: OTPConsumeRequest) async throws -> OTPConsumeResponse {
        return try await apiClient.post(
            endpoint: .otpConsume,
            body: request
        )
    }
}
