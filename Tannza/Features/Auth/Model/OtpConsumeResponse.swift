//
//  OtpConsumeResponse.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 03/04/2026.
//

import Foundation

/// Top-level response from the `/otp/consume` endpoint.
struct OTPConsumeResponse: Decodable {
    /// Indicates whether the OTP was verified successfully.
    let success: Bool
    /// A human-readable message from the server (e.g. "OTP verified").
    let message: String
    /// Optional payload returned alongside the success flag.
    let data: OTPConsumeResponseData?
}

/// Nested payload within `OTPConsumeResponse`.
struct OTPConsumeResponseData: Decodable {
    /// An additional message included in the response data, if any.
    let message: String?
}
