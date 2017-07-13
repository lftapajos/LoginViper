//
//  PerfilWireframe.swift
//  LoginViper
//
//  Created by Luiz Felipe Gomes on 10/07/17.
//  Copyright © 2017 Luiz Felipe Gomes. All rights reserved.
//

import UIKit

class PerfilWireframe {
    
    var window: UIWindow! = nil
    
    //Funçao para carregar a viewController
    func present(user: Usuario, in window: UIWindow) {
        
        self.window = window
        
        //Declara o Presenter de Login
        let presenter = PerfilPresenter(user: user)
        
        //Declara o interacor e cria uma dependência com o Presenter
        let interactor = PerfilInteractor(presenter: presenter, dataManager: PerfilUserDataManager())
        
        //Cria uma dependência do Presenter com o Interactor
        presenter.interactor = interactor
        
        //Declara a Viewcontroller de Login
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: PerfilUserViewControllerIdentifier) as? PerfilUserViewController
        
        //Presenter recebe a dependência da viewController
        presenter.view = viewController
        presenter.wireframe = self
        
        //viewController recebe a dependência do Presenter
        viewController?.presenter = presenter
        
        
        //Adiciona a Viewcontroller ao Root
        window.rootViewController = viewController
        
    }
    
    func showUser() {
        let loginWireframe = LoginWireframe()
        loginWireframe.present(in: self.window)
    }
    
}
