// 
//  LoginPresenter.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import Foundation
import Combine

class LoginPresenter {
    
    private let interactor: LoginInteractor
    private let router = LoginRouter()
    var anyCancellable = Set<AnyCancellable>()

    init(interactor: LoginInteractor) {
        self.interactor = interactor
    }
    
    func fetchCourseList(email: String, password: String) {
        interactor.fetchLogin(email: email, password: password)
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error): break
                }
            }, receiveValue: { loginResponse in
                DispatchQueue.main.async {
                    if loginResponse.message.lowercased() == "login success" {
                        self.router.goToHome()
                    }
                }
            })
            .store(in: &anyCancellable)
    }
    
}
