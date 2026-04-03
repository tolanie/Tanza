//
//  Endpoint.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 12/03/2026.
//

/// Describes a single API endpoint: its path (relative to the base URL) and HTTP method.
/// Add new endpoints here as static properties so they stay discoverable in one place.
struct Endpoint {
    let path: String
    let method: String

    /// `POST /otp` — triggers an OTP SMS to the user's phone number.
    static var otp: Endpoint {
        Endpoint(path: "/otp", method: "POST")
    }

    /// `POST /otp/consume` — verifies the OTP code entered by the user.
    static var otpConsume: Endpoint {
        Endpoint(path: "/otp/consume", method: "POST")
    }
}
