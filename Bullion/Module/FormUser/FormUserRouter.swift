// 
//  FormUserRouter.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import UIKit

class FormUserRouter {
    
    func showView() -> FormUserView {
        let interactor = FormUserInteractor()
        let presenter = FormUserPresenter(interactor: interactor)
        let view = FormUserView(nibName: String(describing: FormUserView.self), bundle: nil)
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
