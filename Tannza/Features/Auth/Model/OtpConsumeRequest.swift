//
//  OtpConsumeRequest.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 03/04/2026.
//

import Foundation

struct OTPConsumeRequest: Codable {
    let otpType: OTPType
    let reference: String
    let code: String
}
