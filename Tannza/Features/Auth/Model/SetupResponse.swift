//
//  SetupResponse.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 13/04/2026.
//

import Foundation

struct SignupResponse: Decodable {
    let success: Bool
    let message: String?
    let data: SignupData?
}

struct SignupData: Decodable {
    let accessToken: String
    let user: UserProfile?
}

struct UserProfile: Codable {
    let id: String?
    let email: String?
    let mobile: String?
    let firstName: String?
    let lastName: String?
    let role: String?
    let profilePic: String?
    let countryCode: String?
    let registrationDate: String?
    let updatedAt: String?
    let registrationMode: String?
    let usersAddress: UsersAddress?
}


/*
 {
     "success": true,
     "message": "Request successful",
     "data": {
         "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsInN1YiI6IjNhM2I5M2Y4LWMxMjEtNDU4My1hMjJjLTJlZTMxMjY1MjBjZCIsImlhdCI6MTc1ODIyMTA0MCwiZXhwIjoxNzU4MzA3NDQwfQ.n9tUGMFGjE3S4GysoPghNCsvWfkHLFsijEJ542rcc_s",
         "user": {
             "id": "3a3b93f8-c121-4583-a22c-2ee3126520cd",
             "email": "oloruntoba@gmail.com",
             "mobile": "9053065927",
             "firstName": "Gloria",
             "lastName": "Oloruntoba",
             "role": "user",
             "profilePic": "https://variety.com/wp-content/uploads/2024/06/5N7A0541-e1718042484447.jpg?w=1000&h=667&crop=1",
             "countryCode": "+234",
             "registrationDate": "2025-09-18T18:44:00.568Z",
             "updatedAt": "2025-09-18T18:44:00.568Z",
             "registrationMode": "manual",
             "usersAddress": {
                 "name": "Victoria Island",
                 "lat": 6.4300279,
                 "lon": 3.42599
             }
         }
     }
 }
 */
