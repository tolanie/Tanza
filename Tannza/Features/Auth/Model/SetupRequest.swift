//
//  SetupRequest.swift
//  Tannza
//
//  Created by Tolanie❤️😘😎😌 on 13/04/2026.
//

struct SetupRequest: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let mobile: String
    let password: String
    let otp: String
    let profilePic: String
    let countryCode: String
    let usersAddress: UsersAddress
}

struct UsersAddress: Codable{
    var lat: Double
    var lon: Double
    var name: String
}

/*
 {
   "lastName": "Oloruntoba",
   "firstName": "Gloria",
   "email": "oloruntoba@gmail.com",
   "mobile": "9053065927",
   "password": "12345678",
   "otp": "4707",
   "profilePic": "https://variety.com/wp-content/uploads/2024/06/5N7A0541-e1718042484447.jpg?w=1000&h=667&crop=1",
   "countryCode": "+234",
   "usersAddress": {
     "lat": 6.4300279,
     "lon": 3.425990,
     "name": "Victoria Island"
   }
 }
 */
