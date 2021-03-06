//
//  LoginPresenter.swift
//  LoginViper
//
//  Created by Luiz Felipe Gomes on 07/07/17.
//  Copyright © 2017 Luiz Felipe Gomes. All rights reserved.
//

import Foundation

//Protoculo de Input da View para o Presenter
protocol LoginPresenterInput {
    
    //Carrega função de input da View para o Presenter
    func didTapLoginButton(email: String, password: String)
    
    func alertSuccessDismissed()
}

//Protocolo de Output do Presenter para a View
protocol LoginPresenterOutput {
    
    //Função que retorna erro de Login para a View
    func showAlert(alertTitle: String, buttonText: String, errorMessage: String)
    
    //Função que retorna sucesso de Login para a View
    func showAlertSuccess(alertTitle: String, buttonText: String, message: String)
    
}

//Classe Presenter de Login
class LoginPresenter {
    
    //Cria variável de Referenecia da View para Output
    var view: LoginPresenterOutput?
    
    //Cria variável de Referenecia do Interactor para Input
    var interactor: LoginInteractorInput?
    
    //Cria variável de Referenecia da do Wireframe para navegação
    var wireframe: LoginWireframe?
    
    var user: Usuario?
    
}

//Extende a referência de Input do Presenter para o Interactor
extension LoginPresenter: LoginPresenterInput {
    
    //Funcão que passa para a o Interactor os campos carregados na View para o Login
    func didTapLoginButton(email: String, password: String) {
        interactor?.login(email: email, password: password)
    }
    
    //Wirefrae chama ViewController de PerfilUser
    func alertSuccessDismissed() {
        self.wireframe?.showUserDetail(user: self.user)
    }
}

extension LoginPresenter: LoginInteractorOutuput {
    
    func loginDidFailed(codeError: ErrorValidationResult) {
        
        let emailInvalid = "O E-mail é inválido."
        let passwordInvalid = "A Senha é inválida."
        let noResults = "Usuário não encontrado."
        
        switch codeError {
        case .failureEmail:
            self.view?.showAlert(alertTitle: "Atenção", buttonText: "OK", errorMessage: emailInvalid)
            
        case .failurePassword:
            self.view?.showAlert(alertTitle: "Atenção", buttonText: "OK", errorMessage: passwordInvalid)
            
        case .failureService:
            self.view?.showAlert(alertTitle: "Atenção", buttonText: "OK", errorMessage: noResults)
        }

    }
    
    func loginSuccess(user: Usuario?) {
        
        let loginSuccessValid = "Login efetuado com sucesso!"
        self.user = user
        self.view?.showAlertSuccess(alertTitle: "Atenção", buttonText: "OK", message: loginSuccessValid)
    }
    
}
