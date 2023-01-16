//
//  KeychainManager.swift
//  KeyChainTest
//
//  Created by wito on 12/01/23.
//

import Foundation
import Security



class KeychainManager {
    
    var genericPasswordQuery = [String: AnyObject]()
    var keychainItemData = [String: AnyObject]()
    
    private let secClass = kSecClass as String
    private let secAttrGeneric = kSecAttrGeneric as String
    private let secMatchLimit = kSecMatchLimit as String
    private let secAttrAccessGroup = kSecAttrAccessGroup as String
    private let secReturnAttributes = kSecReturnAttributes as String
    private let secAttrLabel = kSecAttrLabel as String
    private let secAttrDescription = kSecAttrDescription as String
    private let secAttrAccount = kSecAttrAccount as String
    private let secValueDate = kSecValueData as String
    private let secReturnData = kSecReturnData as String
    
    
    
    init(identifier: String, accessGroup: String?) {
        self.genericPasswordQuery[secClass] = kSecClassGenericPassword
        self.genericPasswordQuery[secAttrGeneric] = identifier as AnyObject?
        
        //Solo si trae acces Group
       // self.genericPasswordQuery[secAttrAccessGroup] = accessGroup as AnyObject?
        
        self.genericPasswordQuery[secMatchLimit] = kSecMatchLimitOne
        self.genericPasswordQuery[secReturnAttributes] = kCFBooleanTrue
        
        var outDict: AnyObject?
        
        let copyMatchingResult = SecItemCopyMatching(genericPasswordQuery as CFDictionary, &outDict)
        if copyMatchingResult == errSecItemNotFound {
            self.resetKeychain()
            
            self.keychainItemData[secAttrGeneric] = identifier as AnyObject?
            if accessGroup != nil {
                self.keychainItemData[secAttrAccessGroup] = accessGroup as AnyObject?
            }
            self.keychainItemData["identificador"] = "" as AnyObject?
        }
        else {
            if let keychainValue = outDict as? [String: AnyObject] {
                self.keychainItemData = self.dictToSecItemData(dict: keychainValue)
            }
        }
    }
    
   
    subscript(key: String) -> String? {
        get{
            return self.keychainItemData[key] as? String
        }
        set(newValue) {
            self.keychainItemData[key] = newValue as AnyObject
            self.writeKeychainData()
        }
    }
    
    func getValueKeychain(key: String, attr: String? = nil) {
        
    }
    
    func resetKeychain() {
        if  !self.keychainItemData.isEmpty {
            let  tempDict = self.dictToSecItemData(dict: self.keychainItemData)
            var noError = noErr
            noError = SecItemDelete(tempDict as CFDictionary)
            
            assert(noError == noErr || noError == errSecItemNotFound, "Failed to delet")
        }
        self.keychainItemData.removeAll()
    }
    
    
    
    func dictToSecItemData(dict: [String:AnyObject]) -> [String: AnyObject] {
        var returnDict = dict
        
        returnDict[secClass] = kSecClassGenericPassword
        if let pass = returnDict[secValueDate] as? String {
            returnDict[secValueDate] = pass.data(using: String.Encoding.utf8) as AnyObject?
        }
        
        return returnDict
    }
    
    
    func writeKeychainData() {
        var attr: AnyObject?
        var updateItem: [String: AnyObject]? = [String: AnyObject]()
        
        var result: OSStatus?
        
        let copyMatchingResult = SecItemCopyMatching(self.genericPasswordQuery as CFDictionary, &attr)
        
        if copyMatchingResult != noErr {
            result = SecItemAdd(self.dictToSecItemData(dict: self.keychainItemData) as CFDictionary, nil)
            
            assert(result != noErr, "Fail to add keychain")
        }else {
            for (key, value) in attr as! [String:AnyObject] {
                updateItem![key] = value
            }
            updateItem![secClass] = self.genericPasswordQuery[secClass]
            
            var tempCheck = self.dictToSecItemData(dict: self.keychainItemData)
            tempCheck.removeValue(forKey: secClass)
            
            result = SecItemUpdate(updateItem! as CFDictionary, tempCheck as CFDictionary)
            assert(result == noErr, "Failed to update keychain")
        }
    }
    
}
