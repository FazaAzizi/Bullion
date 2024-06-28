// 
//  FormUserInteractor.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import Foundation
import Combine

class FormUserInteractor {
    
    open var api = ApiManager()

    func fetchRegister(data: UserModel) -> AnyPublisher<RegisterResponse, Error> {
        return api.requestApiPublisher(.register(data: data), isHaveFile: true)
    }
    
    func fetchUpdateUser(data: UserModel) -> AnyPublisher<UpdateResponse, Error> {
        return api.requestApiPublisherNew(.updateuser(data: data))
    }
}
