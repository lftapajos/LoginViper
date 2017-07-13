//
//  LoginAPI.swift
//  LoginViper
//
//  Created by Luiz Felipe Gomes on 12/07/17.
//  Copyright © 2017 Luiz Felipe Gomes. All rights reserved.
//

import Foundation
import Alamofire

class LoginAPI {
    
    var email = ""
    var password = ""
    
    func getUser(completion: @escaping (UserLoginAPI)->(), failureBlock: @escaping ()->Void) {
        
        let url = "\(apiRequest)carregaUsuario.php?email=\(email)&password=\(password)"
        
        Alamofire.request(url).responseJSON { response in
            //print("Request: \(String(describing: response.request))")   // original url request
            //print("Response: \(String(describing: response.response))") // http url response
            //print("Result: \(response.result)")                         // response serialization result
            //print("Value: \(String(describing: response.result.value))")
            
            if let json = response.result.value as? Dictionary<String,Any> {
                if let jsonResult = json as? Dictionary<String,String> {
                    let idUser = jsonResult["id"]!
                    let nameUser = jsonResult["nome"]!
                    let emailUser = jsonResult["email"]!
                    let phoneUser = jsonResult["telefone"]!
                    let celphoneUser = jsonResult["celular"]!
                    let addressUser = jsonResult["endereco"]!
                    
                    //Recupera dados e prepara modelo de retorno do LoginUserDetail
                    let user = UserLoginAPI(
                        id: idUser,
                        name: nameUser,
                        email: emailUser,
                        phone: phoneUser,
                        celphone: celphoneUser,
                        address: addressUser)
                    
                    completion(user)
                    
                } else {
                    //Retorna erro de Login com o Serviço
                    failureBlock()
                }
            }
        }
    }
}
