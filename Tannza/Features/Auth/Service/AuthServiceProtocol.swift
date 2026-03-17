//
//  AuthServiceProtocol.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 12/03/2026.
//

import Foundation

protocol AuthServiceProtocol {
    func sendOtp(request: OTPRequest) async throws -> OTPResponse
}
