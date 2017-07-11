//
//  LoginUserMapAPI.swift
//  LoginViper
//
//  Created by Luiz Felipe Gomes on 10/07/17.
//  Copyright © 2017 Luiz Felipe Gomes. All rights reserved.
//

import Foundation

class LoginUserMapAPI {
    
    var id = ""
    var name = ""
    var latitude = ""
    var longitude = ""
    
    init(id: String, name: String, latitude: String, longitude: String) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
}
