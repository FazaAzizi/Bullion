// 
//  FormUserRouter.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import UIKit

class FormUserRouter {
    
    func showView(type: FormUserType, data: UserModel? = nil) -> FormUserView {
        let interactor = FormUserInteractor()
        let presenter = FormUserPresenter(interactor: interactor, data: data, type: type)
        let view = FormUserView(nibName: String(describing: FormUserView.self), bundle: nil)
        view.presenter = presenter
        return view
    }
}
