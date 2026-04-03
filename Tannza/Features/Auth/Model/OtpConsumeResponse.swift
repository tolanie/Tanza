//
//  OtpConsumeResponse.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 03/04/2026.
//

import Foundation

struct OtpConsumeResponse: Decodable {
    let success: Bool
    let message: String
    let data: OtpConsumeResponseData?
}

struct OtpConsumeResponseData: Decodable {
    let message: String?
}
