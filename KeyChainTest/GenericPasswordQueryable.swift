//
//  GenerucPasswordQueryable.swift
//  KeyChainTest
//
//  Created by wito on 15/01/23.
//

import Foundation



struct GenericPasswordQueryable {
    
    let service: String
    let accesGroup: String?
    
    init(service: String, accessGroup: String? = nil) {
        self.service = service
        self.accesGroup = accessGroup
    }
}

extension GenericPasswordQueryable: SecureStoreQueryable {
    var query: [String : Any] {
        var query: [String: Any] = [:]
        query[String(kSecClass)] = kSecClassGenericPassword
        query[String(kSecAttrService)] = service
        
        return query
    }
    
    
}
