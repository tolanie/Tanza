//
//  Endpoint.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 12/03/2026.
//

struct Endpoint {

    let path: String
    let method: String

    static var otp: Endpoint {
        Endpoint(path: "/otp", method: "POST")
    }
}
