// 
//  HomePresenter.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import Foundation
import Combine
import UIKit

class HomePresenter {
    
    private let interactor: HomeInteractor
    private let router = HomeRouter()
    var anyCancellable = Set<AnyCancellable>()
    
    var offset = 0
    var limit = 10
    
    var hasMoreData = true
    var isLoading = false
    
    @Published public var usersList: [UserModel] = []
    
    init(interactor: HomeInteractor) {
        self.interactor = interactor
    }
    
    func resetFetchState() {
        self.offset = 0
        self.hasMoreData = true
        self.isLoading = false
        self.usersList.removeAll()
    }
    
    func fetchUsersList() {
        guard hasMoreData, !isLoading else { return }
        isLoading = true
        interactor.fetchUsersList(offset: offset, limit: limit)
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                switch completion {
                   case .finished:
                       self.isLoading = false
                   case .failure(let error):
                       self.isLoading = false
                   }
            }, receiveValue: { [weak self] homeResponse in
                guard let self = self else { return }
                if homeResponse.data.count < self.limit {
                    self.hasMoreData = false
                } else {
                    self.offset += self.limit
                }
                
                self.usersList.append(contentsOf: homeResponse.data)
            })
            .store(in: &anyCancellable)
    }
    
    func showPopupDetail(nav: UINavigationController, data: UserModel, delegate: PopupDetailDelegate) {
        router.showPopupDetail(nav: nav, data: data, delegate: delegate)
    }
    
    func goToEditData(nav: UINavigationController, data: UserModel) {
        router.goToEditData(nav: nav, data: data)
    }
    
    func goToAddData(nav: UINavigationController) {
        router.goToAddData(nav: nav)
    }
    
    func logOut(nav: UINavigationController) {
        router.logOut(nav: nav)
    }
}
