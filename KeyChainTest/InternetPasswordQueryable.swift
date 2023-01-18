//
//  InternetPasswordQueryable.swift
//  KeyChainTest
//
//  Created by wito on 17/01/23.
//

import Foundation



class InternetPasswordQueryable {
    let server: String?
    let port: Int?
    let path: String?
    let securityDomain: String?
    let internetProtocol: InternetProtocol?
    let internetAuthenticationType: InternetAuthenticationType?
    
    init(server: String, port: Int, path: String, securityDomain: String, internetProtocol: InternetProtocol, internetAuthType: InternetAuthenticationType){
        self.server = server
        self.port = port
        self.path = path
        self.securityDomain = securityDomain
        self.internetProtocol = internetProtocol
        self.internetAuthenticationType = internetAuthType
        
    }
}





extension InternetPasswordQueryable: SecureStoreQueryable {
    var query: [String : Any] {
        var query: [String: Any] = [:]
        query[String(kSecClass)] = kSecClassInternetPassword
        query[String(kSecAttrPort)] = port
        query[String(kSecAttrServer)] = server
        query[String(kSecAttrSecurityDomain)] = securityDomain
        query[String(kSecAttrPath)] = path
        query[String(kSecAttrProtocol)] = internetProtocol?.getProtocol(internetProtocol: .httpProtocol)
        query[String(kSecAttrAuthenticationType)] = internetAuthenticationType?.rawValue
        
        return query
    }
    
    
}
