//
//  LoginUserDataManager.swift
//  LoginViper
//
//  Created by Luiz Felipe Gomes on 11/07/17.
//  Copyright © 2017 Luiz Felipe Gomes. All rights reserved.
//

import Foundation
import Alamofire

protocol LoginUserDataManagerProtocol {
    func login(email: String, password: String, successBlock: @escaping((LoginUserDetailAPI)->Void) , failureBlock: @escaping ()->Void)
}

class LoginUserDataManager: LoginUserDataManagerProtocol {
    
    //Função de Login do Interacor para o DataManager
    func login(email: String, password: String, successBlock: @escaping((LoginUserDetailAPI)->Void) , failureBlock: @escaping ()->Void) {

        //Faz Request por meio do DataManager(serviços)
            //Alamofire
            let url = "\(apiRequest)carregaUsuario.php?email=\(email)&password=\(password)"
            //print("url ==> \(url)")
            
            Alamofire.request(url).responseJSON { response in
                //print("Request: \(String(describing: response.request))")   // original url request
                //print("Response: \(String(describing: response.response))") // http url response
                //print("Result: \(response.result)")                         // response serialization result
                
                if let json = response.result.value as? Array<Dictionary<String,Any>> {
                    //print("JSON: \(json)") // serialized json response
                    //print("id ==> "json["id"][0])
                    if let jsonResult = json as? Array<Dictionary<String,String>> {
                        let idUser = jsonResult[0]["id"]!
                        let nameUser = jsonResult[0]["nome"]!
                        let emailUser = jsonResult[0]["email"]!
                        let phoneUser = jsonResult[0]["telefone"]!
                        let celphoneUser = jsonResult[0]["celular"]!
                        let addressUser = jsonResult[0]["endereco"]!
                        
                        //Recupera dados e prepara modelo de retorno do LoginUserDetail
                        let dataSet = LoginUserDetailAPI.init(id: idUser, name: nameUser, email: emailUser, phone: phoneUser, celphone: celphoneUser, address: addressUser)
                        //print("dataResults ==> \(dataResults)")
                        
                        successBlock(dataSet)
                        
                    } else {
                        //Retorna erro de Login com o Serviço
                        failureBlock()
                    }
                }
            }
    }
    
}
