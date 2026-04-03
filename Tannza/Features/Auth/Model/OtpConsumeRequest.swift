//
//  OtpConsumeRequest.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 03/04/2026.
//

/// Request body for `POST /otp/consume`.
/// Submits the OTP code entered by the user along with their phone number
/// so the server can verify the session.
struct OTPConsumeRequest: Encodable {
    /// The channel through which the original OTP was delivered.
    let otpType: OTPType
    /// The phone number that received the OTP (must match the original request).
    let reference: String
    /// The 4-digit code the user entered.
    let code: String
}
