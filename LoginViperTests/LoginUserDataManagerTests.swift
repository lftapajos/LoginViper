//
//  LoginUserDataManagerTests.swift
//  LoginViper
//
//  Created by Luiz Felipe Gomes on 14/07/17.
//  Copyright © 2017 Luiz Felipe Gomes. All rights reserved.
//

import XCTest
@testable import LoginViper

class LoginUserDataManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testUserLoginTransformToUserModel() {
        let userApi = self.userLoginAPIMock()
        
        let user = Usuario(userAPI: userApi)
        
        //Teste se os ampos do modelo da aplicação é igual ao modelo da API
        //Retorno Correto
        XCTAssertTrue(user.id == userApi.id)
        XCTAssertTrue(user.name == userApi.name)
        XCTAssertTrue(user.email == userApi.email)
        XCTAssertTrue(user.phone == userApi.phone)
        XCTAssertTrue(user.address == userApi.address)
       
        //Retorno com Erro
        XCTAssertFalse(user.phone == userApi.celphone)
    }
 
    
    // MOCK
    func userLoginAPIMock() -> UserLoginAPI {
        return UserLoginAPI(id: "1", name: "Jose", email: "jose@dominio.com", phone: "1010", celphone: "", address: "Sem teto")
    }
}
