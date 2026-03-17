//
//  LoginResponse.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 12/03/2026.
//

struct OTPResponse: Decodable {
    let success: Bool
    let message: String
    let data: String? 
}



/*
 {
     "success": true,
     "message": "Request successful",
     "data": "OTP created successfully"
 }
 */
