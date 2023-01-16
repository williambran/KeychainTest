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
        
    //    try? secureStoreWithGenericPwd.removeAllValue()
        
        super.tearDown()

    }

    func test_setPasswordTokeychain() throws {
        do {
            try secureStoreWithGenericPwd.setValue(into1: "123456789", into2: "gnericPassword")
        }
        catch {
            XCTFail("Fallo al salvarlo")
        }
    }

    func test_getPasswordOfKeychain() {
        var password : String?
        
        do {
            try secureStoreWithGenericPwd.setValue(into1: "123456789", into2: "gnericPassword")
            password =  try secureStoreWithGenericPwd.getValue(into2: "gnericPassword")
        }
        catch {
            XCTFail("Fallo al salvarlo")
        }
        
        
        XCTAssertEqual(password, "123456789")
    }

}
