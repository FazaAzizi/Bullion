//
//  FormUserPresenter.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import Foundation
import Combine

class FormUserPresenter {
    
    private let interactor: FormUserInteractor
    private let router = FormUserRouter()
    var type: FormUserType = .add
    var data: UserModel?
    var anyCancellable = Set<AnyCancellable>()
    
    @Published public var isSuccess: Bool = false
    @Published public var isSuccessUpdate: Bool = false
    
    init(interactor: FormUserInteractor, data: UserModel? = nil, type: FormUserType) {
        self.interactor = interactor
        self.type = type
        if let data = data {
            self.data = data
        }
    }
    
    func fetchRegister(data: UserModel) {
        interactor.fetchRegister(data: data)
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print("------ eror \(error.localizedDescription)")
                }
            }, receiveValue: { regisResponse in
                DispatchQueue.main.async {
                    if regisResponse.message.lowercased() == "register success" {
                        self.isSuccess = true
                    }
                }
            })
            .store(in: &anyCancellable)
    }
    
    func fetchUpdateUser(data: UserModel) {
        interactor.fetchUpdateUser(data: data)
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print("------ eror \(error.localizedDescription)")
                }
            }, receiveValue: { regisResponse in
                DispatchQueue.main.async {
                    if regisResponse.message.lowercased() == "update user success" {
                        self.isSuccessUpdate = true
                    }
                }
            })
            .store(in: &anyCancellable)
    }
    
    
}
