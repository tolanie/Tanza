//
//  OTPView.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 24/02/2026.
//

import SwiftUI

struct OTPView: View {
    @StateObject var viewModel: OtpConsumeViewModel
    @Environment(\.dismiss) var dismiss

    // MARK: - Local State

    /// Remaining seconds before the resend button becomes active.
    @State private var timeRemaining = 60
    /// The running countdown timer; invalidated when time reaches zero or view disappears.
    @State private var timer: Timer?
    /// The raw OTP string typed by the user (max 4 digits).
    @State private var otpText = ""
    /// Controls keyboard focus for the hidden text field.
    @FocusState private var isFocused: Bool

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            VStack(alignment: .leading, spacing: 24) {

                // Logo
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)

                // Heading and phone change link
                VStack(alignment: .leading, spacing: 18) {
                    Text(Strings.OTP.title(phone: viewModel.phoneNumber))
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)

                    // Allows the user to go back and correct their number
                    Button {
                        dismiss()
                    } label: {
                        Text(Strings.OTP.changeNumber)
                            .lineLimit(nil)
                            .foregroundColor(.gray)
                            .font(.body)
                            .underline()
                    }
                }
                .padding(.bottom, 10)
            }

            // MARK: - OTP Input Boxes

            HStack(spacing: 20) {
                ForEach(0..<4) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(borderColor(for: index), lineWidth: 2)
                            .frame(width: 60, height: 60)

                        Text(digit(at: index))
                            .font(.title)
                    }
                }
            }
            .onTapGesture {
                // Bring up keyboard when the user taps anywhere on the boxes
                isFocused = true
            }

            // Hidden text field that captures keyboard input and feeds the OTP boxes
            TextField("", text: $otpText)
                .keyboardType(.numberPad)
                .focused($isFocused)
                .frame(width: 0, height: 0)
                .opacity(0.01)
                .onChange(of: otpText) {
                    // Enforce a maximum of 4 digits
                    if otpText.count > 4 {
                        otpText = String(otpText.prefix(4))
                    }
                }

            // MARK: - Resend Button

            Button {
                // Only allow resend when the countdown has finished
                if timeRemaining == 0 {
                    startTimer()
                }
            } label: {
                Text(Strings.OTP.resendButton(time: formattedTime))
                    .foregroundColor(.gray)
                    .font(.body)
            }

            Spacer()
                .onAppear {
                    isFocused = true
                    startTimer()
                }

            // MARK: - Next Button

            ButtonView(
                title: Strings.OTP.nextButton,
                backgroundColor: Color("Light"),
                isDisabled: otpText.count < 4,
                foregroundColor: .white
            ) {
                viewModel.consumeOtp(code: otpText)
            }
            .padding(.bottom, 60)
            .disabled(otpText.count < 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        // Navigate to EmailView once OTP is verified
        .navigationDestination(isPresented: $viewModel.shouldNavigateToEmail) {
            EmailView()
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

    // MARK: - Timer Helpers

    /// Starts (or restarts) the 60-second resend countdown.
    private func startTimer() {
        timer?.invalidate()
        timeRemaining = 60

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
            }
        }
    }

    /// Returns the countdown formatted as `M:SS`.
    private var formattedTime: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%d:%02d", minutes, seconds)
    }

    // MARK: - OTP Display Helpers

    /// Returns the character at `index` in `otpText`, or an empty string if not yet typed.
    private func digit(at index: Int) -> String {
        guard index < otpText.count else { return "" }
        let stringIndex = otpText.index(otpText.startIndex, offsetBy: index)
        return String(otpText[stringIndex])
    }

    /// Returns the border colour for the box at `index`.
    /// The currently active box (next digit slot) is highlighted in black.
    private func borderColor(for index: Int) -> Color {
        otpText.count == index ? .black : .gray
    }
}

// MARK: - Preview

#Preview {
    let apiClient = APIClient()
    let authService = AuthService(apiClient: apiClient)
    let viewModel = OtpConsumeViewModel(phoneNumber: "+2349153065907", authService: authService)
    OTPView(viewModel: viewModel)
}
