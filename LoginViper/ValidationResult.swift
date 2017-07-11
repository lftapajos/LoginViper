//
//  ValidationResult.swift
//  LoginViper
//
//  Created by Luiz Felipe Gomes on 10/07/17.
//  Copyright © 2017 Luiz Felipe Gomes. All rights reserved.
//

import Foundation

public enum ErrorValidationResult : Int {
    case failureEmail  = 1
    case failurePassword  = 2
    case failureService = 3
}
