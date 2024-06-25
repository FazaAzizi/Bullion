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
    
    //Navigate to other xib-based router
    /*
    func navigateToOtherView(from navigation: UINavigationController, with data: Any) {
        let otherView = OtherViewRouter().showView(with: data)
        navigation.pushViewController(otherView, animated: true)
    }
    */
    
    //Navigate to other storyboard-based router
    /*
    func navigateToOtherView(from navigation: UINavigationController, with data: Any) {
        let otherView = OtherViewRouter().showView(with: data)
        navigation.pushViewController(otherView, animated: true)
    }
     */
    
}
