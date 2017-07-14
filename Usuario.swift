//
//  Usuario.swift
//  LoginViper
//
//  Created by Luiz Felipe Gomes on 12/07/17.
//  Copyright © 2017 Luiz Felipe Gomes. All rights reserved.
//

import UIKit

class Usuario: NSObject {
    
    var id = ""
    var name = ""
    var email = ""
    var phone = ""
    var celphone = ""
    var address = ""
    
    init(id: String, name: String, email: String, phone: String, celphone: String, address: String) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.celphone = celphone
        self.address = address
    }
}

extension Usuario {
    
    convenience init(userAPI: UserLoginAPI) {
        self.init(id: userAPI.id, name: userAPI.name, email: userAPI.email, phone: userAPI.phone, celphone: userAPI.celphone, address: userAPI.address)
    }
}
