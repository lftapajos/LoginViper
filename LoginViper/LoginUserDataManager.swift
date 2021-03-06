//
//  LoginUserDataManager.swift
//  LoginViper
//
//  Created by Luiz Felipe Gomes on 11/07/17.
//  Copyright © 2017 Luiz Felipe Gomes. All rights reserved.
//

import Foundation
import Alamofire

//Login User Data Manager
class LoginUserDataManager: LoginDataManager { 
    
    //Declara a API de Login
    var api = LoginAPI()
    
    //Reescreve a função de Login do Data Manager da Aplicação
    override func login(email: String, password: String, completion: @escaping (Usuario) -> (), failureBlock: @escaping ()->Void) {
        
        var user: Usuario?
        
        //API recebe os parâmentros de entrada: E-mail e Password
        api.email = email
        api.password = password
        
        //Chamada o método que vai popular os Dados do usuário logado, vindos da API, mas com o moedelo da Aplicação.
        api.getUser(completion: { (userLogged) in

            //Carrega os dados com o Modelo de Usuario da Aplicação
            user = Usuario(userAPI: userLogged)
            
            completion(user!)

        }, failureBlock: {
            failureBlock()
        })
    }
    
}
