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
