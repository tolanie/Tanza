//
//  OtpResponse.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 12/03/2026.
//

/// Response from `POST /otp`.
struct OTPResponse: Decodable {
    /// Whether the OTP was dispatched successfully.
    let success: Bool
    /// A human-readable message from the server (e.g. "OTP sent").
    let message: String
    /// Optional payload; currently unused but reserved for future server changes.
    let data: String?
}
