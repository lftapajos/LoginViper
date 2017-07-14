//
//  PerfilUserDataManagerTests.swift
//  LoginViper
//
//  Created by Luiz Felipe Gomes on 14/07/17.
//  Copyright © 2017 Luiz Felipe Gomes. All rights reserved.
//

import XCTest

//Importa a Aplicação como um teste
@testable import LoginViper

class PerfilUserDataManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUserPerfilTransformToPerfilModel() {
        
        let userLocationApi = self.userLocationAPIMock()
        let userLocation = UsuarioLocation(userLocationAPI: userLocationApi)
        
        //Teste se os ampos do modelo da aplicação é igual ao modelo da API
        
        //Retornos Corretos por Tipos de Dados dos Modelos
        XCTAssertTrue(userLocation.name == userLocationApi.name)
        XCTAssertTrue(userLocation.lastname == userLocationApi.lastname)
        XCTAssertTrue(userLocation.latitude == userLocationApi.latitude)
        XCTAssertTrue(userLocation.longitude == userLocationApi.longitude)
        
        //Retornos Corretos por Dados
        XCTAssertTrue(userLocation.name == "Jose")
        XCTAssertTrue(userLocation.lastname == "Silva")
        XCTAssertTrue(userLocation.latitude == "-22.999888")
        XCTAssertTrue(userLocation.longitude == "-43.330840")
        
        
        //Retornos com Erros por Tipos de Dados dos Modelos
        XCTAssertFalse(userLocation.latitude == userLocationApi.longitude)
        XCTAssertFalse(userLocation.longitude == userLocationApi.latitude)
        //Latitude não pode ser igual a Longitue
        
        //Retornos com Erros por Dados
        XCTAssertFalse(userLocation.name == "Jorge")
        XCTAssertFalse(userLocation.lastname == "Conte")
    }
    
    
    // MOCK
    func userLocationAPIMock() -> UsuarioLocation {
        return UsuarioLocation(name: "Jose", lastname: "Silva", latitude: "-22.999888", longitude: "-43.330840")
    }
    
}
