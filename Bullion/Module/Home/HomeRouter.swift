// 
//  HomeRouter.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import UIKit

class HomeRouter {
    
    func showView() -> HomeView {
        let interactor = HomeInteractor()
        let presenter = HomePresenter(interactor: interactor)
        let view = HomeView(nibName: String(describing: HomeView.self), bundle: nil)
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
