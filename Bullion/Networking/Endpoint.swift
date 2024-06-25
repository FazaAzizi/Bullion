//
//  Endpoint.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import Foundation
import Alamofire

enum Endpoint {
    case login
    case register
    case getuserlist
    case getdetailuser
    case updateuser
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
        case .getuserlist:
            return "v1/admin"
        case .getdetailuser:
            return "v1/admin"
        case .updateuser:
            return "v1/admin"
        case .deleteuser:
            return "v1/admin"
        }
    }
}

// MARK: Method
extension Endpoint {
    func method() -> HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
}

// MARK: Parameter
extension Endpoint {
    var parameter: [String: Any]? {
        switch self {
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
            let token = "your_bearer_token_here"
            let params: HTTPHeaders = [
                "Accept": "*/*",
                "Authorization": "Bearer \(token)"
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
