//
//  OtpConsumeViewModel.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 03/04/2026.
//
import SwiftUI
import Combine
import SwiftData

@MainActor
final class OtpConsumeViewModel: ObservableObject {
//    @Published var code = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var shouldNavigateToEmail = false
    @Query var users: [UserData]


    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }

    func consumeOtp(code: String) {
        // Clear previous messages
        errorMessage = nil
        shouldNavigateToEmail = false
        isLoading = true

        Task {
            do {
                let request = OTPConsumeRequest(otpType: .mobile, reference: users.first?.phoneNumber ?? "", code: code)
                let response = try await authService.sendOtpConsume(request: request)

                isLoading = false

                // Handle response
                if response.success {
                    // Navigate to email view on success
                    shouldNavigateToEmail = true
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

