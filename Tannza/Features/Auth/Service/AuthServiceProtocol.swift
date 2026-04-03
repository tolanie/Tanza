//
//  AuthServiceProtocol.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 12/03/2026.
//

import Foundation

/// Defines the authentication operations available to the app.
/// View models depend on this abstraction rather than the concrete `AuthService`,
/// which makes them easy to test with a mock implementation.
protocol AuthServiceProtocol {
    /// Requests an OTP to be sent to the phone number in `request`.
    func sendOtp(request: OTPRequest) async throws -> OTPResponse

    /// Submits the OTP code the user entered to verify their identity.
    func sendOtpConsume(request: OTPConsumeRequest) async throws -> OTPConsumeResponse
}
