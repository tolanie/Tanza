//
//  LoginRequest.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 12/03/2026.
//

struct OTPRequest: Codable {
    let otpType: OTPType
    let reference: String
}

enum OTPType: String, Codable {
    case mobile = "MOBILE"
}
