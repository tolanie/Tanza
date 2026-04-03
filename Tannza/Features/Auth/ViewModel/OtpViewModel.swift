//
//  OtpViewModel.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 12/03/2026.
//

import SwiftUI
import Combine

/// Manages the state for the phone-number entry screen (SignUpView).
///
/// Responsibilities:
/// - Holds the phone number the user types.
/// - Calls `POST /otp` via `AuthServiceProtocol` to trigger an OTP SMS.
/// - Publishes loading / error / navigation state back to the view.
@MainActor
final class OtpViewModel: ObservableObject {

    // MARK: - Published State

    /// The phone number bound to the text field in SignUpView.
    @Published var phoneNumber = ""

    /// `true` while the OTP request is in flight; used to show a loading overlay.
    @Published var isLoading = false

    /// Non-nil when an error occurred; the view presents this in an alert.
    @Published var errorMessage: String?

    /// Flips to `true` after a successful `/otp` response to trigger navigation to OTPView.
    @Published var shouldNavigateToOTP = false

    // MARK: - Dependencies

    private let authService: AuthServiceProtocol

    // MARK: - Init

    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }

    // MARK: - Actions

    /// Sends `POST /otp` with the current `phoneNumber`.
    /// On success, sets `shouldNavigateToOTP = true`.
    /// On failure, populates `errorMessage` for the view to display.
    func login() {
        // Reset state from any previous attempt
        errorMessage = nil
        shouldNavigateToOTP = false
        isLoading = true

        Task {
            defer { isLoading = false }

            do {
                let request = OTPRequest(otpType: .mobile, reference: phoneNumber)
                let response = try await authService.sendOtp(request: request)

                if response.success {
                    shouldNavigateToOTP = true
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
