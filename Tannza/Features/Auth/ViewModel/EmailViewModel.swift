//
//  EmailViewModel.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 06/04/2026.
//

import SwiftUI
import Combine

/// Manages all state and business logic for `EmailView`.
///
/// Owns the email input value, validation state, loading state, and
/// navigation trigger. The view binds directly to these published properties
/// and calls `verifyEmail()` when the user taps Continue.
@MainActor
final class EmailViewModel: ObservableObject {

    // MARK: - Published State

    /// The current value of the email text field, bound bidirectionally from the view.
    @Published var email = ""

    /// Becomes `true` the moment the user makes any change to the email field.
    /// Used to suppress validation UI until the user has actually started typing.
    @Published var hasEditedEmail = false

    /// `true` while the `verifyEmail` network request is in flight.
    /// The view uses this to show/hide the loading overlay.
    @Published var isLoading = false

    /// Set to a non-nil string when the API call fails.
    /// The view presents this as an alert; clearing it also dismisses the alert.
    @Published var errorMessage: String?

    /// Flipped to `true` by the view model after a successful API response.
    /// The view's `navigationDestination` observes this to push `SetupView`.
    @Published var shouldNavigateToSetup = false
    
    @Published var mobile = ""
    
    @Published var otp = ""

    // MARK: - Computed Validation

    /// Client-side email validation — intentionally lightweight.
    ///
    /// We only check enough to enable the CTA and avoid obviously bad network calls.
    /// Full RFC-5322 validation is left to the server.
    ///
    /// Rules:
    /// - At least 5 characters after trimming whitespace.
    /// - Matches `local@domain.tld` where the TLD is at least 2 characters.
    var isEmailValid: Bool {
        let trimmed = email.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmed.count >= 5 else { return false }

        // Regex breakdown:
        //   ^[^\s@]+   — one or more non-whitespace, non-@ chars (local part)
        //   @          — literal @
        //   [^\s@]+    — one or more non-whitespace, non-@ chars (domain)
        //   \.         — literal dot
        //   [^\s@]{2,}$ — at least 2 non-whitespace, non-@ chars (TLD)
        let regex = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/
        return trimmed.wholeMatch(of: regex) != nil
    }

    /// `true` when the field has been edited AND the current value is invalid.
    /// Drives both the red border on the text field and the inline error label.
    var showValidationError: Bool {
        hasEditedEmail && !isEmailValid
    }

    // MARK: - Dependencies

    /// Handles the actual API communication. Injected at init for testability.
    private let authService: AuthServiceProtocol

    // MARK: - Init

    /// - Parameter authService: The service used to verify the email with the backend.
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }

    // MARK: - Actions

    /// Calls the auth service to check whether the email exists on the backend.
    ///
    /// Resets error and navigation state before each attempt so stale values
    /// from a previous call never bleed into the new one.
    /// Trims whitespace before sending so the server receives a clean value.
    /// On success, sets `shouldNavigateToSetup` to push the next screen.
    /// On failure, populates `errorMessage` for the view to display in an alert.
    func verifyEmail() {
        // Reset state from any previous attempt before starting a new one.
        errorMessage = nil
        shouldNavigateToSetup = false
        isLoading = true

        Task {
            defer { isLoading = false } // Always clear the spinner, even on error.

            do {
                let response = try await authService.getEmail(email: email)

                if response.success {
                    shouldNavigateToSetup = true
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

