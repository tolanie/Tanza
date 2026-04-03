//
//  OnboardingView.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 19/02/2026.
//

import SwiftUI

struct OnboardingView: View {

    // MARK: - Dependencies

    /// Passed in from ContentView so the same instance is reused on the SignUpView.
    let otpViewModel: OtpViewModel

    /// Binding to the AppStorage flag in ContentView.
    /// Setting this to `true` causes ContentView to swap to SignUpView and
    /// ensures the onboarding screen is never shown again after reinstall.
    @Binding var hasSeenOnboarding: Bool

    // MARK: - Private State

    @State private var navigateToSignUp = false

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ZStack {
                Image("BGImage")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack {
                    VStack(alignment: .leading, spacing: 16) {
                        Text(Strings.Onboarding.headline)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)

                        Text(Strings.Onboarding.subtitle)
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 80)

                    Spacer()

                    Button(Strings.Onboarding.continueButton) {
                        // Mark onboarding as complete so it is never shown again.
                        hasSeenOnboarding = true
                        navigateToSignUp = true
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: 300)
                    .padding()
                    .background(Color("Light"))
                    .cornerRadius(16)
                    .navigationDestination(isPresented: $navigateToSignUp) {
                        SignUpView(viewModel: otpViewModel)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    let apiClient = APIClient()
    let authService = AuthService(apiClient: apiClient)
    let viewModel = OtpViewModel(authService: authService)
    OnboardingView(otpViewModel: viewModel, hasSeenOnboarding: .constant(false))
}
