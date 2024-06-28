// 
//  HomeInteractor.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import Foundation
import Combine

class HomeInteractor {
    open var api = ApiManager()

    func fetchUsersList(offset: Int, limit: Int) -> AnyPublisher<HomeResponse, Error> {
        return api.requestApiPublisherNew(.getuserlist(offset: offset, limit: limit))
    }
}
