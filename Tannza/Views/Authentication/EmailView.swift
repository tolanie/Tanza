//
//  EmailView.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 26/02/2026.
//

import SwiftUI

/// The email entry screen — the first step in the auth flow.
///
/// Responsibilities:
/// - Renders the logo, title, subtitle, and email text field.
/// - Delegates all state and business logic to `EmailViewModel`.
/// - Shows a red border + error label when the user has typed an invalid email.
/// - Disables the continue button until the email passes client-side validation.
/// - Presents a full-screen loading overlay while the network request is in flight.
/// - Shows an alert if the server returns an error.
/// - Navigates to `SetupView` on success.
struct EmailView: View {

    // The view model owns all state and logic for this screen.
    // `@StateObject` ensures it is created once and kept alive for this view's lifetime.
    @StateObject var viewModel: EmailViewModel
    
    

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            // MARK: - Header
            // App logo + title/subtitle copy stacked vertically.
            VStack(alignment: .leading, spacing: 24) {

                // App logo — sourced from the asset catalogue.
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)

                // Title and subtitle explaining what this screen is for.
                VStack(alignment: .leading, spacing: 8) {
                    Text(Strings.Email.title)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)

                    Text(Strings.Email.subtitle)
                        .lineLimit(nil)       // Allow subtitle to wrap onto multiple lines.
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
            }
            .padding(.top, 60) // Push header down from the navigation bar.

            // MARK: - Input
            // Email text field + optional validation error label.
            VStack(alignment: .leading, spacing: 8) {

                TextField(Strings.Email.placeholder, text: $viewModel.email)
                    // Mark the field as "dirty" on first edit so we only show
                    // validation feedback after the user has started typing.
                    .onChange(of: viewModel.email) {
                        viewModel.hasEditedEmail = true
                    }
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)   // Prevent iOS from capitalising the first character.
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    // Red border is shown only when validation has failed after editing.
                    // Uses `.clear` rather than removing the overlay to avoid layout shifts.
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(
                                viewModel.showValidationError ? Color.red : Color.clear,
                                lineWidth: 1
                            )
                    )

                // Inline error label — only visible when `showValidationError` is true.
                if viewModel.showValidationError {
                    Text(Strings.Email.validationError)
                        .font(.subheadline)
                        .foregroundColor(.red)
                }
            }
            .padding(.top, 16)

            Spacer()

            // MARK: - Continue Button
            // Disabled until `isEmailValid` is true; tapping triggers the network call.
            ButtonView(
                title: Strings.Email.continueButton,
                backgroundColor: Color("Light"),
                isDisabled: !viewModel.isEmailValid,
                foregroundColor: .white
            ) {
                viewModel.verifyEmail()
            }
            .padding(.bottom, 60)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()

        // MARK: - Navigation
        // Programmatically triggered by the view model after a successful API response.
        .navigationDestination(isPresented: $viewModel.shouldNavigateToSetup) {
            makeSetupView()
        }
        // MARK: - Error Alert
        // Shown when `errorMessage` is set by the view model (e.g. network or server error).
        // Dismissing the alert clears `errorMessage`, which also dismisses the alert binding.
        .alert(Strings.Common.errorTitle, isPresented: Binding(
            get: { viewModel.errorMessage != nil },
            set: { if !$0 { viewModel.errorMessage = nil } }
        )) {
            Button(Strings.Common.okButton) { viewModel.errorMessage = nil }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }

        // MARK: - Loading Overlay
        // A semi-transparent black scrim with a white spinner, shown while the
        // API request is in flight. `ignoresSafeArea()` ensures the scrim covers
        // the full screen including the navigation bar area.
        .overlay {
            if viewModel.isLoading {
                ZStack {
                    Color.black.opacity(0.3).ignoresSafeArea()
                    ProgressView()
                        .scaleEffect(1.5)
                        .tint(.white)
                }
            }
        }
    }
    
    private func makeSetupView() -> some View {
        let authService = AuthService(apiClient: APIClient())
        let setupVM = SetupViewModel(authService: authService)
        setupVM.email = viewModel.email
        setupVM.mobile = viewModel.mobile
        setupVM.otp = viewModel.otp
        return SetupView(viewModel: setupVM)
    }
}

#Preview {
    let apiClient = APIClient()
    let authService = AuthService(apiClient: apiClient)
    let viewModel = EmailViewModel(authService: authService)
    EmailView(viewModel: viewModel)
}
