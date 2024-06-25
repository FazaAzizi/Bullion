// 
//  LoginRouter.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import UIKit

class LoginRouter {
    
    func showView() -> LoginView {
        let interactor = LoginInteractor()
        let presenter = LoginPresenter(interactor: interactor)
        let view = LoginView(nibName: String(describing: LoginView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
    
    func goToHome() {
        let vc = HomeRouter().showView()
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = vc
            window.makeKeyAndVisible()
        }
    }
    
}
