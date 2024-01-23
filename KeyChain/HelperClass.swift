//
//  HelperClass.swift
//  KeyChain
//
//  Created by WEMA on 22/01/2024.
//

import Foundation
final class KeychainHelper {
    static let shared: KeychainHelper = KeychainHelper()
    private init() {}
    func save(_ data: Data, account: String) {
        
        // Create query
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
        ] as CFDictionary
        
        // Add data in query to keychain
        let status = SecItemAdd(query, nil)
        
        if status != errSecSuccess {
            // Print out the error
            print("Error: \(status.description)")
            
            if (status.description == "-25299") {
                let attributesToUpdate = [kSecValueData: data] as CFDictionary
                //
                // Update existing item
                SecItemUpdate(query, attributesToUpdate)
            }
        }
    }
    
    func save<T>(_ item: T, account: String) where T : Codable {
        
        do {
            // Encode as JSON data and save in keychain
            let data = try JSONEncoder().encode(item)
            save(data, account: account)
            
        } catch {
            assertionFailure("Fail to encode item for keychain: \(error)")
        }
    }
    
    func read(account: String) -> Data? {
        
        let query = [
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
    
    func read<T>(account: String, type: T.Type) -> T? where T : Codable {
        
        // Read item data from keychain
        guard let data = read(account: account) else {
            return nil
        }
        
        // Decode JSON data to object
        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            assertionFailure("Fail to decode item for keychain: \(error)")
            return nil
        }
    }
}
