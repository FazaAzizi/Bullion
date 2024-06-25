// 
//  LoginPresenter.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import Foundation

class LoginPresenter {
    
    private let interactor: LoginInteractor
    private let router = LoginRouter()
    
    init(interactor: LoginInteractor) {
        self.interactor = interactor
    }
    
}
