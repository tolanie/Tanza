//
//  OtpViewModel.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 12/03/2026.
//

import SwiftUI
import Combine

@MainActor
final class OtpViewModel: ObservableObject {
    @Published var phoneNumber = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var shouldNavigateToOTP = false

    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }

    func login() {
        // Clear previous messages
        errorMessage = nil
        shouldNavigateToOTP = false
        isLoading = true

        Task {
            do {
                let request = OTPRequest(otpType: .mobile, reference: phoneNumber)
                let response = try await authService.sendOtp(request: request)

                isLoading = false

                // Handle response
                if response.success {
                    // Navigate to OTP view on success
                    shouldNavigateToOTP = true
                } else {
                    errorMessage = response.message
                }

            } catch {
                errorMessage = "Login Failed"
                isLoading = false
            }
        }
    }
}

