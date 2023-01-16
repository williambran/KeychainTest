//
//  SecureStore.swift
//  KeyChainTest
//
//  Created by wito on 15/01/23.
//

import Foundation




class SecureStore {
    
    var secureStoreQueryable: SecureStoreQueryable
     
    init(secureStoreQueryable: SecureStoreQueryable ) {
        self.secureStoreQueryable = secureStoreQueryable
    }
    
    public func setValue(password: String, account: String) throws  {
        
        guard let encodePassword = password.data(using: .utf8) else {
            throw SecureStoreError.stringDataConversionError
        }
        
        var query = secureStoreQueryable.query
        query[String(kSecAttrAccount)] = account
        
        
        var status = SecItemCopyMatching(query as CFDictionary, nil)
        
        switch status {
        case errSecSuccess:
            var attributesToUpdate: [String: Any] = [:]
            attributesToUpdate[String(kSecValueData)] = encodePassword
            
            status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
            if status != errSecSuccess {
                throw SecureStoreError.stringDataConversionError
            }
            
        case errSecItemNotFound:
            query[String(kSecValueData)] = encodePassword
            status = SecItemAdd(query as CFDictionary, nil)
            if status != errSecSuccess {
                throw SecureStoreError.stringDataConversionError
            }
            
        default:
            throw SecureStoreError.stringDataConversionError
        }
        
    }
    
    
    
    func getValue(into2: String) throws -> String? {
        var query = secureStoreQueryable.query
        query[String(kSecMatchLimit)] = kSecMatchLimitOne
        query[String(kSecReturnAttributes)] = kCFBooleanTrue
        query[String(kSecReturnData)] = kCFBooleanTrue
        query[String(kSecAttrAccount)] = into2
        
        
        var queryresult: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &queryresult)
        
        
        switch status {
        case errSecSuccess:
            guard
                let queriedItem  = queryresult as? [String:Any],
                let passwordData = queriedItem[String(kSecValueData)] as? Data,
                let password = String(data: passwordData, encoding: .utf8)
            else {throw SecureStoreError.stringDataConversionError }
            
            return password
            
        case errSecItemNotFound:
            return nil
                    
        default:
            throw SecureStoreError.stringDataConversionError
        }
       
    }
    
    
    func  removeAllValue() throws {
        var query = secureStoreQueryable.query
       // query[String(kSecAttrAccount)] = into2   agregar cuado sea borrado de un solo valor 
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw SecureStoreError.stringDataConversionError
        }
    }
    
    func removeValue(account: String) throws {
        var query = secureStoreQueryable.query
        
        query[String(kSecAttrAccount)] = account
        let status = SecItemDelete(query as CFDictionary)
        guard  status == errSecSuccess || status == errSecItemNotFound else {
            throw SecureStoreError.stringDataConversionError
        }
    }
    
    
    func error(from: OSStatus)-> String  {
        switch from {
        case errSecSuccess:
            return "no error"
        case errSecDuplicateItem:
            return "Error duplicdo"
        case errSecAllocate:
        return "No loclizado"
        case errSecItemNotFound:
            return "no encontrado"
        default:
            return "error desconocido"
        }
    }
}
