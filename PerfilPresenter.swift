//
//  PerfilPresenter.swift
//  LoginViper
//
//  Created by Luiz Felipe Gomes on 10/07/17.
//  Copyright © 2017 Luiz Felipe Gomes. All rights reserved.
//

import Foundation
import UIKit
import MapKit

protocol PerfilPresenterOutput {
    func showInfoUser(id: String, name: String, email: String, phone: String, celphone: String, address: String)
    func showLogoff(alertTitle: String, buttonText: String, message: String)
    func showUserLocationInMap(name: String, latitude: String, longitude: String)
}

protocol PerfilPresenterInput {
    func viewDidLoad()
    func didTapButtonShowMap()
    func didTapCloseButton()
    
}

class PerfilPresenter {
    
    //Cria variável de Referenecia da View para Output
    var view: PerfilPresenterOutput?
    
    //Cria variável de Referenecia do Interactor para Input
    var interactor: PerfilInteractorInput?
    
    //Cria variável de Referenecia da do Wireframe para navegação
    var wireframe: PerfilWireframe?
    
    let user: LoginUserDetailAPI
    
    init(user: LoginUserDetailAPI) {
        self.user = user
    }
}

extension PerfilPresenter: PerfilPresenterInput {
    func viewDidLoad() {
        
        //Retorna para a ViewController os dados do usuário logado
        self.view?.showInfoUser(id: self.user.id, name: self.user.name, email: self.user.email, phone: self.user.phone, celphone: self.user.celphone, address: self.user.address)
        
    }
    
    func didTapButtonShowMap() {
        
        //Passa para o indereactor o id do usuário
        interactor?.getUserLocation(from: user.id)
    }
    
    func didTapCloseButton() {
        self.view?.showLogoff(alertTitle: "Atenção", buttonText: "OK", message: "Você saiu")
        self.wireframe?.showUser()
        
    }
}

extension PerfilPresenter: PerfilInteractorOutput {
    
    func didFailLoadUserLocation() {
        self.view?.showLogoff(alertTitle: "Atenção", buttonText: "OK", message: "Falha ao trazer a localização do usuário.")
    }
    func didLoadUserLocation(user: LoginUserMapAPI) {
        self.view?.showUserLocationInMap(name: user.name, latitude: user.latitude, longitude: user.longitude)
    }
}
