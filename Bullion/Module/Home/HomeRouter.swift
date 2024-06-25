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
    
    func showPopupDetail(nav: UINavigationController, data: UserModel, delegate: PopupDetailDelegate) {
        let popupDetail = PopupDetail(nibName: String(describing: PopupDetail.self), bundle: nil)
        popupDetail.modalPresentationStyle = .overFullScreen
        popupDetail.modalTransitionStyle = .crossDissolve
        popupDetail.data = data
        popupDetail.delegate = delegate
        nav.present(popupDetail, animated: true)
    }
    
    func goToEditData(nav: UINavigationController, data: UserModel) {
        let vc = FormUserRouter().showView(type: .edit, data: data)
        nav.pushViewController(vc, animated: true)
    }
    
    func goToAddData(nav: UINavigationController) {
        let vc = FormUserRouter().showView(type: .add)
        nav.pushViewController(vc, animated: true)
    }
    
    func logOut(nav: UINavigationController) {
        let vc = LoginRouter().showView()
        nav.pushViewController(vc, animated: true)
    }
}
