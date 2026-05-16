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

    /// `GET /user/exists/email` — verifies if the user exists.
    /// Pass `email` via `queryParams` at the call site:
    /// `apiClient.get(endpoint: .userExistsByEmail, queryParams: ["email": email])`
    static var userExistsByEmail: Endpoint {
        Endpoint(path: "/user/exists/email", method: "GET")
    }
    
    static var signup: Endpoint {
        Endpoint(path: "/auth/sign-up", method: "POST")
    }
}
