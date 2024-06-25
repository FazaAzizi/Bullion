// 
//  HomeEntity.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import Foundation

struct HomeResponse: Codable {
    let status: Int
    let iserror: Bool
    let message: String
    let data: [UserModel]
}

struct UserModel: Codable {
    let id, name, gender, dateOfBirth: String
    let email, photo, phone, address: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, gender
        case dateOfBirth = "date_of_birth"
        case email, photo, phone, address
    }
}
