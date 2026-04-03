//
//  OtpRequest.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 12/03/2026.
//

/// Request body for `POST /otp`.
/// Asks the server to send a one-time password to the given reference (phone number).
struct OTPRequest: Encodable {
    /// The channel through which the OTP will be delivered.
    let otpType: OTPType
    /// The recipient's phone number (e.g. "+2349153065907").
    let reference: String
}

/// The delivery channel for an OTP.
enum OTPType: String, Encodable {
    case mobile = "MOBILE"
}
