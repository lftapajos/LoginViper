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

//Procolo de Output do Interactor para a o Presenter
protocol LoginInteractorOutuput {
    
    //Função que retorna Falha de Login
    func loginDidFailed(codeError: ErrorValidationResult)
    
    //Função que retorna o Login efetuado com sucesso
    func loginSuccess(user: Usuario?)
    
}

//Classe Inetractor do Login
class LoginInteractor {
    
    //Declara o Presenter de Output do Interactor para o Presenter
    var presenter: LoginInteractorOutuput
    
    //Declara o DataManager com o Protocolo de Login
    let dataManager: LoginUserDataManager //LoginUserDataManagerProtocol
    
    //Construtor do Presenter para Output do Interacor para o Presenter
    init(presenter: LoginInteractorOutuput, dataManager: LoginUserDataManager) {  //LoginUserDataManagerProtocol
        self.presenter = presenter
        self.dataManager = dataManager
    }
}

extension LoginInteractor: LoginInteractorInput {
    //Função de Login do Interacor para o DataManager
    func login(email: String, password: String) {
        
        //Valida o E-mail
        //Se o E-mail é valido, segue a função
        guard self.isValidEmail(email: email) else {
            //Senão retorna ao Presenter E-mail inválido.
            return self.presenter.loginDidFailed(codeError: .failureEmail)
        }
        
        //Valida Pasword
        //Se a Senha é valida, segue a função
        guard self.isValidPassword(password: password) else {
            //Senão retorna ao Presenter Senha inválida.
            return self.presenter.loginDidFailed(codeError: .failurePassword)
        }
        
        //Faz Request por meio do DataManager(serviços)
        self.dataManager.login(email: email, password: password, completion: { (userLogged) in
            //Callback de Login com sucesso
            self.presenter.loginSuccess(user: userLogged)
            //print("Retorno userLogged ==> \(userLogged[0].id)")
        }, failureBlock: {
            self.presenter.loginDidFailed(codeError: .failureService)
        })
        
    }
    
    func isValidEmail(email: String) -> Bool {
        return email.isValidEmail
    }
    
    func isValidPassword(password: String) -> Bool {
        return password.characters.count > 3
    }
    
    func numberOfVowels(in string: String) -> Int {
        let vowels: [Character] = ["a", "e", "i", "o", "u",
                                   "A", "E", "I", "O", "U"]
        var numberOfVowels = 0
        for character in string.characters {
            if vowels.contains(character) {
                numberOfVowels += 1
            }
        }
        return numberOfVowels
    }
}

extension String {
    
    //Validate Email
    var isValidEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
}
