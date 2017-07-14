//
//  UserLocationAPI.swift
//  LoginViper
//
//  Created by Luis Felipe Tapajos on 13/07/17.
//  Copyright © 2017 Luiz Felipe Gomes. All rights reserved.
//

import UIKit

class UserLocationAPI: NSObject {
    var name = ""
    var lastname = ""
    var latitude = ""
    var longitude = ""
    
    init(name: String, lastname: String, latitude: String, longitude: String) {
        self.name = name
        self.lastname = lastname
        self.latitude = latitude
        self.longitude = longitude
    }
}
