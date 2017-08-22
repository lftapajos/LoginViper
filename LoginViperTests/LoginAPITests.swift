//
//  LoginAPITests.swift
//  LoginViper
//
//  Created by Luiz Felipe Gomes on 14/07/17.
//  Copyright © 2017 Luiz Felipe Gomes. All rights reserved.
//

import XCTest
@testable import LoginViper

class LoginAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAsynchronousURLConnection() {
        let email = "jose@gmail.comm"
        let password = "12345678"
        
        for index in 1...1 {
            
            print("Test - \(index)")
            
            let url = URL(string: "http://www.appeguei.com.br/loginviper/carregaUsuario.php?email=\(email)&password=\(password)")!
            
            let urlExpectation = expectation(description: "GET \(url)")
            
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                XCTAssertNotNil(data, "Dados não podem ser nulos")
                XCTAssertNil(error, "Não podem ter erros")
                
                if let response = response as? HTTPURLResponse,
                    let responseURL = response.url,
                    let mimeType = response.mimeType
                {
                    XCTAssertEqual(responseURL.absoluteString, url.absoluteString, "HTTP response URL deve ser igual a URL original")
                    XCTAssertEqual(response.statusCode, 200, "O código de status do HTTP deve ser 200")
                    XCTAssertEqual(mimeType, "application/json", "O conteúdo do HTTP response deve ser application/json")
                } else {
                    XCTFail("Response não é uma NSHTTPURLResponse")
                }
                
                urlExpectation.fulfill()
            }
            
            task.resume()
            
            waitForExpectations(timeout: task.originalRequest!.timeoutInterval) { error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                task.cancel()
            }
        }
    }
}
