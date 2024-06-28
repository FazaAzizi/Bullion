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
    let id, gender, dateOfBirth: String
    let name: String?
    let email, photo, phone, address: String
    let password: String?
    let firstName: String?
    let lastName: String?

    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, gender
        case dateOfBirth = "date_of_birth"
        case email, photo, phone, address, password
        case firstName = "first_name"
        case lastName = "last_name"
    }
    
    var dictionaryRepresentation: [String: Any] {
        var dictionary: [String: Any] = [
            "first_name": firstName ?? "",
            "last_name": lastName ?? "",
            "gender": gender,
            "date_of_birth": dateOfBirth,
            "email": email,
            "phone": phone,
            "address": address
        ]
        if let password = password {
            dictionary["password"] = password.sha256()
        }
        return dictionary
    }
    
    var dictionaryRepresentationUpdate: [String: Any] {
        var dictionary: [String: Any] = [
            "first_name": firstName ?? "",
            "last_name": lastName ?? "",
            "gender": gender,
            "date_of_birth": dateOfBirth,
            "email": email,
            "phone": phone,
            "address": address
        ]
        return dictionary
    }
}
