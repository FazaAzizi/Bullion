// 
//  HomePresenter.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import Foundation

class HomePresenter {
    
    private let interactor: HomeInteractor
    private let router = HomeRouter()
    
    init(interactor: HomeInteractor) {
        self.interactor = interactor
    }
    
}
