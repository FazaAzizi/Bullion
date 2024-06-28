// 
//  FormUserEntity.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import Foundation

struct FormUserEntity {
    
}

enum FormUserType {
    case add
    case edit
}

struct RegisterResponse: Codable {
    let status: Int
    let isError: Bool
    let message: String
    let data: UserData?

    struct UserData: Codable {
        let name: String
        let email: String
    }
    
    enum CodingKeys: String, CodingKey {
        case status
        case isError = "iserror"
        case message
        case data
    }
}

struct UpdateResponse: Codable {
    let status: Int
    let isError: Bool
    let message: String
    let data: UserModel?
    
    enum CodingKeys: String, CodingKey {
        case status
        case isError = "iserror"
        case message
        case data
    }
}

