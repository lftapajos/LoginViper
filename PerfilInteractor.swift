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
    func didLoadUserLocation(user: LoginUserMapAPI)
    func didFailLoadUserLocation()
}

class PerfilInteractor {
    
    var presenter: PerfilInteractorOutput?
    
    //Declara o DataManager com o Protocolo de Login
    let dataManager: PerfilUserDataManagerProtocol
    
    init(presenter: PerfilInteractorOutput, dataManager: PerfilUserDataManagerProtocol) {
        self.presenter = presenter
        self.dataManager = dataManager
    }
    
}

extension PerfilInteractor: PerfilInteractorInput {
    
    func getUserLocation(from userID: String) {
        
        //Faz Request por meio do DataManager(serviços)
        self.dataManager.getUserLocation(from: userID, successBlock: { (userLogged) in
            self.presenter?.didLoadUserLocation(user: userLogged)
        }, failureBlock: {
            self.presenter?.didFailLoadUserLocation()
        })
    }
}
