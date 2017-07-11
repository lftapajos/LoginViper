//
//  LoginAPI.swift
//  LoginViper
//
//  Created by Luiz Felipe Gomes on 10/07/17.
//  Copyright © 2017 Luiz Felipe Gomes. All rights reserved.
//

import Foundation

class LoginAPI {
    
    func getLogin(completion: ([LoginUserAPI])->()) {
        
        var users = [LoginUserAPI]()
        
        let user = LoginUserAPI(
            email: "jose@teste.com.br",
            password: "12345678")
        
        users.append(user)
        
        completion(users)
    }
    
    func showLogin(completion: ([LoginUserDetailAPI])->()) {
        
        var users = [LoginUserDetailAPI]()
        
        let user = LoginUserDetailAPI(
            id: "",
            name: "",
            email: "",
            phone: "",
            celphone: "",
            address: ""
            )
        
        users.append(user)
        
        completion(users)
    }
    
    func showUserMap(completion: ([LoginUserMapAPI])->()) {
        
        var users = [LoginUserMapAPI]()
        
        let user = LoginUserMapAPI(
            id: "",
            name: "",
            latitude: "",
            longitude: ""
        )
        
        users.append(user)
        
        completion(users)
    }
}
