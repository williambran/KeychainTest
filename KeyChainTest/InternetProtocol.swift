//
//  InternetProtocol.swift
//  KeyChainTest
//
//  Created by wito on 17/01/23.
//

import Foundation




enum InternetProtocol {
    
    case httpProtocol
    case httpsProtocol
    case ftpProtocol
    
    
    
    
    func getProtocol(internetProtocol: Self) -> CFString {
        switch internetProtocol {
        case .httpProtocol:
            return kSecAttrProtocolHTTP
        case .httpsProtocol:
            return kSecAttrProtocolHTTPS
        case .ftpProtocol:
            return kSecAttrProtocolFTP
            
        default:
            return kSecAttrProtocolHTTPS
        }
    }
}




enum InternetAuthenticationType: String {
    
    case  kSecAttrAuthenticationTypeHTTPBasic
}
