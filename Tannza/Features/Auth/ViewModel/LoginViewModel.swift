//
//  LoginViewModel.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 12/03/2026.
//

import SwiftUI
import Combine

@MainActor
final class LoginViewModel: ObservableObject {

    @Published var phoneNumber = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }

    func login() {

        isLoading = true

        Task {

            do {

                let request = OTPRequest(otpType: .mobile, reference: phoneNumber)

                let response = try await authService.sendOtp(request: request)

                print("Token:", response)

                isLoading = false

            } catch {

                errorMessage = "Login Failed"
                isLoading = false
            }
        }
    }
}

