//
//  AuthService.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 12/03/2026.
//

import Foundation

final class AuthService: AuthServiceProtocol {
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func sendOtp(request: OTPRequest) async throws -> OTPResponse {
        return try await apiClient.post(
            endpoint: .otp,
            body: request
        )
    }
    
    func sendOtpConsume(request: OTPConsumeRequest) async throws -> OtpConsumeResponse {
        return try await apiClient.post(
            endpoint: .otpConsume,
            body: request
        )
    }
}

