//
//  GenericPasswordKeychain.swift
//  KeyChainTest
//
//  Created by wito on 15/01/23.
//

import XCTest

@testable import KeyChainTest
class GenericPasswordKeychain: XCTestCase {

    var genericPasswordQueryable: SecureStoreQueryable?
    var secureStoreWithGenericPwd: SecureStore!
    override func setUp()  {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        genericPasswordQueryable = GenericPasswordQueryable(service: "sevicio1", accessGroup: nil)
        secureStoreWithGenericPwd = SecureStore(secureStoreQueryable: genericPasswordQueryable!)

        
        
    }


    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
      // try? secureStoreWithGenericPwd.removeAllValue()
        
        super.tearDown()

    }

    func test_setPasswordTokeychain() throws {
        do {
            try secureStoreWithGenericPwd.setValue(password: "123456789", for: "gnericPassword")
        }
        catch {
            XCTFail("Fallo al salvarlo")
        }
    }

    func test_getPasswordOfKeychain() {
        var password : String?
        
        do {
          //  try secureStoreWithGenericPwd.setValue(password: "123456789", for: "gnericPassword")
            password =  try secureStoreWithGenericPwd.getValue(into2: "gnericPassword")
            print("password", password)
        }
        catch {
            XCTFail("Fallo al salvarlo")
        }
        
        
        XCTAssertEqual(password, "123456789")
    }
    
    func test_getPasswordSaved() {
        var password: String?
        do{
            password =  try secureStoreWithGenericPwd.getValue(into2: "gnericPassword")

        }
        catch {
            
        }
        XCTAssertEqual(password, "123456789")
        
    }
    
    
    func test_updatePassword_couldRetrunThrow(){
        let passwordNew = "passwordNew"
        let accounGeneric = "genericPassword"
        var password: String?
        do{
            try secureStoreWithGenericPwd.setValue(password: "pass_123", for: accounGeneric)
            try secureStoreWithGenericPwd.setValue(password: passwordNew, for: accounGeneric)
            
            password = try secureStoreWithGenericPwd.getValue(into2: accounGeneric )
        }
        catch{
            XCTFail("Fallo al actualizar")

        }
        XCTAssertEqual(password, passwordNew)
    }
    
    func test_deletePasswordKeychain_CouldReturnThrow() {
        let accounGeneric = "genericPassword"
        let accounGeneric2 = "genericPassword2"

        do {
            try secureStoreWithGenericPwd.setValue(password: "pass_123", for: accounGeneric)
            try secureStoreWithGenericPwd.setValue(password: "pass_000", for: accounGeneric2)
            
            try secureStoreWithGenericPwd.removeValue(account: accounGeneric)
            XCTAssertNil(try secureStoreWithGenericPwd.getValue(into2:accounGeneric))
            XCTAssertNotNil(try secureStoreWithGenericPwd.getValue(into2:accounGeneric2), "Se elimino todo el llavero, se esperaba que solo la cuenta seleccionada se eliminara")
        }
        catch{
            
        }
    }
    
    func test_deletedAllPasswordintoKeychain_coudReturnThrow() {
        let accounGeneric = "genericPassword"
        let accounGeneric2 = "genericPassword2"


        do {
            try secureStoreWithGenericPwd.setValue(password: "pass_123", for: accounGeneric)
            try secureStoreWithGenericPwd.setValue(password: "pass_123456", for: accounGeneric2)


            try secureStoreWithGenericPwd.removeAllValue()
            
            XCTAssertNil(try secureStoreWithGenericPwd.getValue(into2:accounGeneric))
            XCTAssertNil(try secureStoreWithGenericPwd.getValue(into2:accounGeneric2))

        }
        catch{
            XCTFail("Fallo ")

        }
        
    }

}
