//
//  ContentView.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 19/02/2026.
//

import SwiftUI

struct ContentView: View {

    // MARK: - Dependencies

    // Constructed once here so they are never recreated on re-render.
    @StateObject private var otpViewModel: OtpViewModel = {
        let apiClient = APIClient()
        let authService = AuthService(apiClient: apiClient)
        return OtpViewModel(authService: authService)
    }()

    // MARK: - Onboarding State

    /// Persisted in UserDefaults via @AppStorage.
    /// Survives app restarts but is reset when the user uninstalls and reinstalls.
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    // MARK: - Body

    var body: some View {
        if hasSeenOnboarding {
            // User has already seen onboarding — go straight to sign up.
            SignUpView(viewModel: otpViewModel)
        } else {
            // First launch — show onboarding. It will flip hasSeenOnboarding on continue.
            OnboardingView(otpViewModel: otpViewModel, hasSeenOnboarding: $hasSeenOnboarding)
        }
    }
}

#Preview {
    ContentView()
}
