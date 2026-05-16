//
//  SetupViewModel.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 13/04/2026.
//

import SwiftUI
import Combine


@MainActor
final class SetupViewModel: ObservableObject {

    // MARK: - Published State

    @Published var lastName = ""
    
    @Published var firstName = ""
    
    @Published var email = ""
    
    @Published var mobile = ""
    
    @Published var password = ""
    
    @Published var otp = ""
    
    @Published var profilePic = ""
    
    @Published var countryCode = "+234"
    
    @Published var usersAddress = UsersAddress(lat: 0.0, lon: 0.0, name: "")
    
    @Published var isLoading = false
    

    /// Non-nil when an error occurred; the view presents this in an alert.
    @Published var errorMessage: String?

    /// Flips to `true` after a successful `/otp` response to trigger navigation to OTPView.
    @Published var shouldNavigateToHome = false

    // MARK: - Dependencies

    private let authService: AuthServiceProtocol

    // MARK: - Init

    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }

    // MARK: - Actions

    /// On success, sets `shouldNavigateToHome = true`.
    /// On failure, populates `errorMessage` for the view to display.
    func setup() {
        // Reset state from any previous attempt
        errorMessage = nil
        shouldNavigateToHome = false
        isLoading = true

        Task {
            defer { isLoading = false }

            do {
                let request = SetupRequest(
                    firstName: firstName,
                    lastName: lastName,
                    email: email,
                    mobile: mobile,
                    password: password,
                    otp: otp,
                    profilePic: profilePic,
                    countryCode: countryCode,
                    usersAddress: usersAddress
                )
                
                let response = try await authService.signup(request: request)

                if response.success {
                    shouldNavigateToHome = true
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

