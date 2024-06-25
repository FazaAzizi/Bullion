// 
//  LoginEntity.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import Foundation

struct LoginResponse: Codable {
    let status: Int
    let isError: Bool
    let message: String
    let data: LoginEntity
    
    enum CodingKeys: String, CodingKey {
        case status
        case isError = "iserror"
        case message
        case data
    }
}

struct LoginEntity: Codable {
    let name: String
    let email: String
    let token: String
}
