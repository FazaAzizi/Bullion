// 
//  FormUserPresenter.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import Foundation

class FormUserPresenter {
    
    private let interactor: FormUserInteractor
    private let router = FormUserRouter()
    var type: FormUserType = .add
    var data: UserModel?
    
    init(interactor: FormUserInteractor, data: UserModel? = nil, type: FormUserType) {
        self.interactor = interactor
        self.type = type
        if let data = data {
            self.data = data
        }
    }
    
}
