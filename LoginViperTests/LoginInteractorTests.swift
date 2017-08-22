//
//  LoginInteractor.swift
//  LoginViper
//
//  Created by Luiz Felipe Gomes on 14/07/17.
//  Copyright © 2017 Luiz Felipe Gomes. All rights reserved.
//

import XCTest
@testable import LoginViper

class LoginInteractorTests: XCTestCase {
    
    var loginInteractor: LoginInteractor!
    
    override func setUp() {
        super.setUp()
        
        let presenter = LoginPresenter()
        let dataManager = LoginUserDataManager()
        self.loginInteractor = LoginInteractor(presenter: presenter, dataManager: dataManager)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //Teste para verificar se o E-mail é válido
    func testValidEmail() {

        //Testes Inválidos
        XCTAssertFalse(loginInteractor.isValidEmail(email: "josecom"))
        XCTAssertFalse(loginInteractor.isValidEmail(email: "jose@.com"))
        XCTAssertFalse(loginInteractor.isValidEmail(email: "jose@dominio"))
        
        //Teste Válido
        XCTAssertTrue(loginInteractor.isValidEmail(email: "jose@dominio.com"))
    }
    
    //Teste para verificar se a Passord é válida
    func testValidPassword() {
        // O teste de senha é válido se tiver mais de 3 caracteres
        
        //Testes Inválidos
        XCTAssertFalse(loginInteractor.isValidPassword(password: ""))
        XCTAssertFalse(loginInteractor.isValidPassword(password: "1"))
        XCTAssertFalse(loginInteractor.isValidPassword(password: "12"))
        XCTAssertFalse(loginInteractor.isValidPassword(password: "123"))
        
        //Teste Válido
        XCTAssertTrue(loginInteractor.isValidPassword(password: "1234"))
    }
    
    //Teste de Exemplo de retorno do número de vogais de um Nome
    func testNumberOfVowelsWhenPassedStringReturnsCount() {
        
        let stringTest = "Jose"
        
        let numberOfVowels = loginInteractor.numberOfVowels(in: stringTest)
        
        XCTAssertEqual(numberOfVowels, 2, "Deve retornar 2")
        //XCTAssertEqual(numberOfVowels, 4, "Deve retornar 3")
        
    }
    
}
