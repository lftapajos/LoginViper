//
//  LoginInteractor.swift
//  LoginViper
//
//  Created by Luiz Felipe Gomes on 07/07/17.
//  Copyright © 2017 Luiz Felipe Gomes. All rights reserved.
//

import Foundation
import Alamofire

//Protocolo de Input do Inetactor
protocol LoginInteractorInput {
    
    //Função de tratamento de Login
    func login(email: String, password: String)
}

//Procolo de POutput do Interactor para a o Presenter
protocol LoginInteractorOutuput {
    
    //Função que retorna Falha de Login
    func loginDidFailed(codeError: ErrorValidationResult)
    
    //Função que retorna o Login efetuado com sucesso
    func loginSuccess(user: LoginUserDetailAPI?)
}

//Classe Inetractor do Login
class LoginInteractor {
    
    //Declara o Presenter de Output do Interactor para o Presenter
    var presenter: LoginInteractorOutuput
    
    //Declara o DataManager com o Protocolo de Login
    let dataManager: LoginUserDataManagerProtocol
    
    //Construtor do Presenter para Output do Interacor para o Presenter
    init(presenter: LoginInteractorOutuput, dataManager: LoginUserDataManagerProtocol) {
        self.presenter = presenter
        self.dataManager = dataManager
    }
}

extension LoginInteractor: LoginInteractorInput {
    //Função de Login do Interacor para o DataManager
    func login(email: String, password: String) {
        
        //Valida o E-mail
        //Se o E-mail é valido, segue a função
        guard email.isValidEmail else {
            //Senão retorna ao Presenter E-mail inválido.
            return self.presenter.loginDidFailed(codeError: .failureEmail)
        }
        
        //Valida Pasword
        //Se a Senha é valida, segue a função
        guard password.characters.count > 3 else {
            //Senão retorna ao Presenter Senha inválida.
            return self.presenter.loginDidFailed(codeError: .failurePassword)
        }
        
        //Faz Request por meio do DataManager(serviços)
        self.dataManager.login(email: email, password: password, successBlock: { (userLogged) in
            //Callback de Login com sucesso
            self.presenter.loginSuccess(user: userLogged)
        }, failureBlock: {
            //Callback de Login com falha no serviço
            self.presenter.loginDidFailed(codeError: .failureService)
        })
    }
}

extension String {
    
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    //Validate Email
    var isValidEmail: Bool {
        
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    //validate Password
    var isValidPassword: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z_0-9\\-_,;.:#+*?=!§$%&/()@]+$", options: .caseInsensitive)
            if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil){
                
                if(self.characters.count>=6 && self.characters.count<=20){
                    return true
                }else{
                    return false
                }
            }else{
                return false
            }
        } catch {
            return false
        }
    }
}
