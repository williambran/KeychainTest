//
//  InternetPasswordKeychain.swift
//  KeyChainTestTests
//
//  Created by wito on 18/01/23.
//

import XCTest
@testable import KeyChainTest

class InternetPasswordKeychain: XCTestCase {

    var secureStore: SecureStore!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let InternetPasswordQueryable = InternetPasswordQueryable(server: "IrisDicenteServer", port: 800, path: "https://irisdicente.com/", securityDomain: "irisdicente.com", internetProtocol: .httpsProtocol, internetAuthType: .kSecAttrAuthenticationTypeHTTPBasic)
        secureStore = SecureStore(secureStoreQueryable: InternetPasswordQueryable)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        try? secureStore.removeAllValue()
        
        super.tearDown()

    }
    
    
    func test_setPasswordTokeychain() {

        do {
            try secureStore.setValue(password: "passwordSaved", for: "InternetPassword")
        } catch  {
            XCTFail("Fallo al gardar la contraseña")
        }
    }
    
    
    
    func test_getPasswordKeychain() {
        let password = "passwordSaved"
        var passwordSaved: String?
        do {
            try secureStore.setValue(password: password, for: "InternetPasssword")
            passwordSaved = try secureStore.getValue(into2: "InternetPasssword")
            
        } catch  {
            XCTFail("Fallo al guardar la contraseña")
        }
        
        XCTAssertEqual(passwordSaved, password)
    }
    
    
    func test_UpdatePassword_CouldReturnThrow() {
        let password = "passwordSaved"
        let passwordUpdate = "nwePassword"
        var passwordSaved: String?
        
        do {
            try secureStore.setValue(password: password, for: "InternetPasssword")
            passwordSaved = try secureStore.getValue(into2: "InternetPasssword")
            XCTAssertEqual(password, passwordSaved)
            
            try secureStore.setValue(password: passwordUpdate, for: "InternetPasssword")
            passwordSaved = try secureStore.getValue(into2: "InternetPasssword")
            XCTAssertNotEqual(password, passwordSaved)
            XCTAssertEqual(passwordSaved, passwordUpdate)

        } catch  {
            XCTFail("Fallo en el proceso")
        }
    }

}
