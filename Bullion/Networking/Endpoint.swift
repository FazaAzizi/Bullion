//
//  Endpoint.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import Foundation
import Alamofire

enum Endpoint {
    case login(email: String, password: String)
    case register(data: UserModel)
    case getuserlist(offset: Int, limit: Int)
    case getdetailuser
    case updateuser(data: UserModel)
    case deleteuser
}

// MARK: Path URL
extension Endpoint {
    func path() -> String {
        switch self {
        case .login:
            return "v1/auth/login"
        case .register:
            return "v1/auth/register"
        case .getuserlist(let offset, let limit):
            return "v1/admin?offset=\(offset)&limit=\(limit)"
        case .getdetailuser:
            return "v1/admin"
        case .updateuser(let data):
            return "v1/admin/\(data.id)/update"
        case .deleteuser:
            return "v1/admin"
        }
    }
}

extension Endpoint {
    func data() -> Any {
        switch self {
        case .register(let data):
            return data
        default:
            return [:] 
        }
    }
}

// MARK: Method
extension Endpoint {
    func method() -> HTTPMethod {
        switch self {
        case .login, .register:
            return .post
        case .updateuser:
            return .put
        default:
            return .get
        }
    }
}

// MARK: Parameter
extension Endpoint {
    var parameter: [String: Any]? {
        switch self {
        case .login(let email, let password):
            let params: [String: Any] = [
                "email": email,
                "password": password
            ]
            return params
        case .updateuser(let data):
            return data.dictionaryRepresentationUpdate
        case .register(let data):
            return data.dictionaryRepresentation
        default:
            return nil
        }
    }
}

// MARK: Header
extension Endpoint {
    var header: HTTPHeaders {
        switch self {
        case .deleteuser, .getdetailuser, .getuserlist, .updateuser :
            let token = UserDefaults.standard.string(forKey: "bearerToken")
            let params: HTTPHeaders = [
                "Accept": "*/*",
                "Authorization": "Bearer \(token ?? "")"
            ]
            return params
        default:
            let params: HTTPHeaders = [
                "Accept": "*/*"
            ]
            return params
        }
    }
}

extension Endpoint {
    func urlString() -> String {
        switch self {
        default:
            return "https://api-test.bullionecosystem.com/api/" + path()
        }
    }
}
