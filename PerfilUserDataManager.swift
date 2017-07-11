//
//  PerfilUserDataManager.swift
//  LoginViper
//
//  Created by Luiz Felipe Gomes on 11/07/17.
//  Copyright © 2017 Luiz Felipe Gomes. All rights reserved.
//

import Foundation
import Alamofire

protocol PerfilUserDataManagerProtocol {
    func getUserLocation(from userID: String, successBlock: @escaping((LoginUserMapAPI)->Void) , failureBlock: @escaping ()->Void)
}

class PerfilUserDataManager: PerfilUserDataManagerProtocol {
    
    func getUserLocation(from userID: String, successBlock: @escaping((LoginUserMapAPI)->Void) , failureBlock: @escaping ()->Void) {
        
        //Faz Request por meio do DataManager(serviços)
        let url = "\(apiRequest)carregaMapa.php?id=\(userID)"
        
        //Chama serviço do DataManager que irá retornar a latitude e longitude do endereço do usuário
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
                    let latitudeUser = jsonResult[0]["latitude"]!
                    let longitudeUser = jsonResult[0]["longitude"]!
                    
                    //Recupera dados e prepara modelo de retorno do LoginUserDetail
                    let dataSet = LoginUserMapAPI.init(id: idUser, name: nameUser, latitude: latitudeUser, longitude: longitudeUser)
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
