//
//  PerfilUserDataManager.swift
//  LoginViper
//
//  Created by Luiz Felipe Gomes on 11/07/17.
//  Copyright © 2017 Luiz Felipe Gomes. All rights reserved.
//

import Foundation
import Alamofire


class PerfilUserDataManager: PerfilDataManager {
    
    //Declara a API de Login
    var api = LoginAPI()
    
    //Reescreve a função de Login do Data Manager da Aplicação
    override func userLocation(id: String, completion: @escaping (UsuarioLocation) -> (), failureBlock: @escaping ()->Void) {
        
        var userLocation: UsuarioLocation?
        
        //API recebe s parâmentro de entrada: Id
        api.id = id
        
        //Chamada o método que vai popular os Dados do usuário logado, vindos da API, mas com o moedelo da Aplicação.
        api.getUserLocation(completion: { (userLogged) in
            
            //Carrega os dados com o Modelo de Usuario da Aplicação
            userLocation = UsuarioLocation(name: userLogged.name, lastname: userLogged.lastname, latitude: userLogged.latitude, longitude: userLogged.longitude)
            
            completion(userLocation!)
            
        }, failureBlock: {
            failureBlock()
        })
    }

}
