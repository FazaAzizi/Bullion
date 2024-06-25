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
    
    @Published public var usersList: [UserModel] = [
        UserModel(id: "1", name: "John Doe", gender: "Male", dateOfBirth: "1990-01-01", email: "john.doe@example.com", photo: "https://example.com/photo1.jpg", phone: "123-456-7890", address: "123 Main St, Anytown, USA"),
        UserModel(id: "2", name: "Jane Smith", gender: "Female", dateOfBirth: "1985-05-15", email: "jane.smith@example.com", photo: "https://example.com/photo2.jpg", phone: "234-567-8901", address: "456 Oak St, Anycity, USA"),
        UserModel(id: "3", name: "Alice Johnson", gender: "Female", dateOfBirth: "1992-07-23", email: "alice.johnson@example.com", photo: "https://example.com/photo3.jpg", phone: "345-678-9012", address: "789 Pine St, Anyville, USA"),
        UserModel(id: "4", name: "Bob Brown", gender: "Male", dateOfBirth: "1988-03-12", email: "bob.brown@example.com", photo: "https://example.com/photo4.jpg", phone: "456-789-0123", address: "101 Maple St, Anystate, USA"),
        UserModel(id: "5", name: "Carol White", gender: "Female", dateOfBirth: "1995-11-30", email: "carol.white@example.com", photo: "https://example.com/photo5.jpg", phone: "567-890-1234", address: "202 Elm St, Anystate, USA"),
        UserModel(id: "6", name: "David Green", gender: "Male", dateOfBirth: "1993-09-14", email: "david.green@example.com", photo: "https://example.com/photo6.jpg", phone: "678-901-2345", address: "303 Cedar St, Anycountry, USA"),
        UserModel(id: "7", name: "Eva Black", gender: "Female", dateOfBirth: "1987-02-25", email: "eva.black@example.com", photo: "https://example.com/photo7.jpg", phone: "789-012-3456", address: "404 Birch St, Anycountry, USA"),
        UserModel(id: "8", name: "Frank Grey", gender: "Male", dateOfBirth: "1991-06-17", email: "frank.grey@example.com", photo: "https://example.com/photo8.jpg", phone: "890-123-4567", address: "505 Walnut St, Anycity, USA"),
        UserModel(id: "9", name: "Grace Blue", gender: "Female", dateOfBirth: "1994-08-05", email: "grace.blue@example.com", photo: "https://example.com/photo9.jpg", phone: "901-234-5678", address: "606 Ash St, Anytown, USA"),
        UserModel(id: "10", name: "Hank Red", gender: "Male", dateOfBirth: "1989-12-03", email: "hank.red@example.com", photo: "https://example.com/photo10.jpg", phone: "012-345-6789", address: "707 Spruce St, Anyville, USA")
    ]
    
    init(interactor: HomeInteractor) {
        self.interactor = interactor
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
