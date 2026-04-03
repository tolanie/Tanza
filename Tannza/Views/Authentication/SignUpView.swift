//
//  SignUpView.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 19/02/2026.
//

import SwiftUI
import SwiftData

struct SignUpView: View {
    @StateObject var viewModel: OtpViewModel
    @Environment(\.modelContext) private var context

    // MARK: - Body

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {

                VStack(alignment: .leading, spacing: 24) {

                    // Logo
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)

                    // Heading and subtitle
                    VStack(alignment: .leading, spacing: 10) {
                        Text(Strings.SignUp.title)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)

                        Text(Strings.SignUp.subtitle)
                            .lineLimit(nil)
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                    .padding(.bottom, 10)
                }

                // MARK: - Phone Number Input

                HStack {
                    // Country code selector (static; extend with a picker if needed)
                    HStack(spacing: 6) {
                        Image("flagg")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)

                        Text(Strings.SignUp.countryCode)
                            .font(.subheadline)

                        Image(systemName: "chevron.down")
                            .font(.caption)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .frame(height: 50)
                    .cornerRadius(8)

                    TextField(Strings.SignUp.phonePlaceholder, text: $viewModel.phoneNumber)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .frame(height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.vertical, 20)

                // MARK: - Sign Up Button

                VStack(spacing: 24) {
                    ButtonView(
                        title: Strings.SignUp.signUpButton,
                        backgroundColor: Color("Light"),
                        isDisabled: false,
                        foregroundColor: .white
                    ) {
                        // Persist the number so OTPView can read it from the view model
                        savePhoneNumber(phoneNumber: viewModel.phoneNumber)
                        viewModel.login()
                    }

                    Text(Strings.SignUp.disclaimer)
                        .font(.caption)
                        .foregroundColor(.black)
                        .lineLimit(nil)
                }

                // MARK: - Social Sign-Up Divider

                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.4))

                    Text(Strings.SignUp.orDivider)
                        .font(.body)
                        .foregroundColor(.gray)

                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.4))
                }
                .padding(.top, 10)

                // MARK: - Social Buttons

                VStack(spacing: 16) {
                    ButtonView(
                        title: Strings.SignUp.googleButton,
                        backgroundColor: .white,
                        hasOverlay: true,
                        isDisabled: false,
                        icon: Image("google"),
                        foregroundColor: .black
                    ) {
                        // TODO: Implement Google Sign-In
                    }

                    ButtonView(
                        title: Strings.SignUp.appleButton,
                        backgroundColor: .white,
                        hasOverlay: true,
                        isDisabled: false,
                        icon: Image(systemName: "applelogo"),
                        foregroundColor: .black
                    ) {
                        // TODO: Implement Apple Sign-In
                    }
                }
                .padding(.top, 16)

                Spacer()

                // MARK: - Sign In Link

                HStack(alignment: .center, spacing: 3) {
                    Text(Strings.SignUp.haveAccount)
                        .foregroundColor(.gray)

                    Button {
                        // TODO: Navigate to LoginView
                    } label: {
                        Text(Strings.SignUp.signInButton)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Light"))
                    }
                }
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()

            // Navigate to OTPView once the OTP has been dispatched.
            // Pass the phone number into OtpConsumeViewModel so OTPView can display it
            // and use it as the `reference` when calling /otp/consume.
            .navigationDestination(isPresented: $viewModel.shouldNavigateToOTP) {
                let authService = AuthService(apiClient: APIClient())
                let consumeViewModel = OtpConsumeViewModel(
                    phoneNumber: viewModel.phoneNumber,
                    authService: authService
                )
                OTPView(viewModel: consumeViewModel)
            }
            .alert(Strings.Common.errorTitle, isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { if !$0 { viewModel.errorMessage = nil } }
            )) {
                Button(Strings.Common.okButton) { viewModel.errorMessage = nil }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
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
    }

    // MARK: - SwiftData

    /// Persists the phone number in SwiftData so it can be displayed in OTPView
    /// (e.g. "Enter the code sent to +2349153065907").
    private func savePhoneNumber(phoneNumber: String) {
        let user = UserData(phoneNumber: phoneNumber)
        context.insert(user)

        do {
            try context.save()
        } catch {
            // Non-fatal: OTP flow can still proceed; phone number will be sourced from the view model.
            print("Failed to persist phone number: \(error)")
        }
    }
}

// MARK: - Preview

#Preview {
    let apiClient = APIClient()
    let authService = AuthService(apiClient: apiClient)
    let viewModel = OtpViewModel(authService: authService)
    SignUpView(viewModel: viewModel)
}
