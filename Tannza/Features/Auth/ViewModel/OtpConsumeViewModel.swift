//
//  OtpConsumeViewModel.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 03/04/2026.
//

import SwiftUI
import Combine

/// Manages the state for the OTP verification screen (OTPView).
///
/// Responsibilities:
/// - Accepts the phone number that was used to request the OTP.
/// - Calls `POST /otp/consume` via `AuthServiceProtocol` to verify the code.
/// - Publishes loading / error / navigation state back to the view.
///
/// Note: `@Query` is a SwiftUI property wrapper and cannot be used inside an
/// `ObservableObject` class. The phone number is therefore passed in at
/// initialisation (from `SignUpView`, where it is already available).
@MainActor
final class OtpConsumeViewModel: ObservableObject {

    // MARK: - Published State

    /// `true` while the consume request is in flight; used to show a loading overlay.
    @Published var isLoading = false

    /// Non-nil when an error occurred; the view presents this in an alert.
    @Published var errorMessage: String?

    /// Flips to `true` after a successful `/otp/consume` response to trigger navigation to EmailView.
    @Published var shouldNavigateToEmail = false

    // MARK: - Private

    /// The phone number that received the original OTP, used as the `reference` in the request.
    /// Exposed as `internal(set)` so `OTPView` can display it in the heading label.
    private(set) var phoneNumber: String

    private let authService: AuthServiceProtocol

    // MARK: - Init

    /// - Parameters:
    ///   - phoneNumber: The phone number that was used when requesting the OTP.
    ///   - authService: The service used to verify the OTP code.
    init(phoneNumber: String, authService: AuthServiceProtocol) {
        self.phoneNumber = phoneNumber
        self.authService = authService
    }

    // MARK: - Actions

    /// Sends `POST /otp/consume` with the code the user typed.
    /// On success, sets `shouldNavigateToEmail = true`.
    /// On failure, populates `errorMessage` for the view to display.
    func consumeOtp(code: String) {
        // Reset state from any previous attempt
        errorMessage = nil
        shouldNavigateToEmail = false
        isLoading = true

        Task {
            defer { isLoading = false }

            do {
                let request = OTPConsumeRequest(
                    otpType: .mobile,
                    reference: phoneNumber,
                    code: code
                )
                let response = try await authService.sendOtpConsume(request: request)

                if response.success {
                    shouldNavigateToEmail = true
                } else {
                    // Surface the server's own message so the user knows what went wrong.
                    errorMessage = response.message
                }
            } catch let networkError as NetworkError {
                errorMessage = networkError.errorDescription
            } catch {
                errorMessage = "An unexpected error occurred. Please try again."
            }
        }
    }
}
