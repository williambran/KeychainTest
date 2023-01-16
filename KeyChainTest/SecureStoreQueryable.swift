//
//  SecureStoreQueryable.swift
//  KeyChainTest
//
//  Created by wito on 15/01/23.
//

import Foundation


protocol SecureStoreQueryable {
    var query: [String: Any] {get}
}




enum SecureStoreError: Error {
case stringDataConversionError
}


extension Error {
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
