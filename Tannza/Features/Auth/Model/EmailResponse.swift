//
//  EmailResponse.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 06/04/2026.
//

import Foundation

struct EmailResponse: Decodable {
    let success: Bool
    let message: String
    let data: EmailDataResponse?
}

struct EmailDataResponse: Decodable {
    let exists: Bool
}
