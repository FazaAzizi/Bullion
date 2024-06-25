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
    
    init(interactor: FormUserInteractor) {
        self.interactor = interactor
    }
    
}
