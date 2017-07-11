//
//  LoginWireframe.swift
//  LoginViper
//
//  Created by Luiz Felipe Gomes on 07/07/17.
//  Copyright © 2017 Luiz Felipe Gomes. All rights reserved.
//


import UIKit

class LoginWireframe {
    
    var window: UIWindow! = nil
    
    //Funçao para carregar a viewController
    func present(in window: UIWindow) {
        self.window = window
        
        //Declara o Presenter de Login
        let presenter = LoginPresenter()
        
        //Declara o interacor e cria uma dependência com o Presenter
        let interactor = LoginInteractor(presenter: presenter, dataManager: LoginUserDataManager())
        
        //Cria uma dependência do Presenter com o Interactor
        presenter.interactor = interactor
        
        //Declara a Viewcontroller de Login
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: LoginUserViewControllerIdentifier) as? LoginUserViewController
        
        //Associa a Viewcontroller com a Inetrface de Logim
        viewController?.eventHandler = presenter as? LoginModuleInterface
        
        //Presenter recebe a dependência da viewController
        presenter.view = viewController
        presenter.wireframe = self
        
        //viewController recebe a dependência do Presenter
        viewController?.presenter = presenter
        
        //Adiciona a Viewcontroller ao Root
        window.rootViewController = viewController
        
    }
    
    func showUserDetail(user: LoginUserDetailAPI) {
        let detailWireframe = PerfilWireframe()
        detailWireframe.present(user: user, in: self.window)
    }

}
