//
//  PerfilInteractor.swift
//  LoginViper
//
//  Created by Luiz Felipe Gomes on 10/07/17.
//  Copyright © 2017 Luiz Felipe Gomes. All rights reserved.
//

import Foundation
import Alamofire

protocol PerfilInteractorInput {
    func getUserLocation(from userID: String)
}

protocol PerfilInteractorOutput {
    
    //Função que retorna os dados do Mapa do usuário
    func didLoadUserLocation(user: UsuarioLocation)
    func didFailLoadUserLocation()
}

class PerfilInteractor {
    
    var presenter: PerfilInteractorOutput?
    
    //Declara o DataManager com o Protocolo de Login
    let dataManager: PerfilUserDataManager
    
    init(presenter: PerfilInteractorOutput, dataManager: PerfilUserDataManager) {
        self.presenter = presenter
        self.dataManager = dataManager
    }
    
}

extension PerfilInteractor: PerfilInteractorInput {
    
    func getUserLocation(from userID: String) {
        
        //Faz Request por meio do DataManager(serviços)
        self.dataManager.userLocation(id: userID, completion: { (userLogged) in
            //Callback de Login com sucesso
            self.presenter?.didLoadUserLocation(user: userLogged)
            //print("Retorno userLogged ==> \(userLogged[0].id)")
        }, failureBlock: {
            self.presenter?.didFailLoadUserLocation()
        })
        
    }
}
