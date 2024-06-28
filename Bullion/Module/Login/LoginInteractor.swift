// 
//  LoginInteractor.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import Foundation
import Combine

class LoginInteractor {
    open var api = ApiManager()

    func fetchLogin(email: String, password: String) -> AnyPublisher<LoginResponse, Error> {
        return api.requestApiPublisherNew(.login(email: email, password: password.sha256()))
    }
}
