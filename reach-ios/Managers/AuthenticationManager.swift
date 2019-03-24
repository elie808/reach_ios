//
//  AuthenticationManager.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/13/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

// Add Keys here for AuthenticationManager methods
extension DefaultsKeys {
    static let authenticationData = DefaultsKey<AuthenticationData?>("authentication-data")
    static let sales = DefaultsKey<[SaleViewModel]?>("sales-list")
}

// Add persistence methods here, as needed
final class AuthenticationManager {
    
    static var isAuthenticated: Bool {
        return (Defaults[.authenticationData] == nil) ? false : true
    }

    static func persistToUserDefaults(authenticationData: AuthenticationData) {
        Defaults[.authenticationData] = authenticationData
        Defaults.synchronize()
    }
    
    static func logout() {
        clearUserDefaults()
    }
    
    private static func clearUserDefaults() {
        Defaults[.authenticationData] = nil
        Defaults.synchronize()
    }
}

final class PersistenceManager {
    
    static func save(saleObject: SaleViewModel) {
        
        // create unique identifier
        var obj = saleObject
        obj.id = Date().timeIntervalSince1970
        
        if var savedArray = Defaults[.sales], savedArray.count > 0 {
            
            savedArray.append(obj)
            Defaults[.sales] = savedArray
            
        } else {
            
            Defaults[.sales] = [obj]
        }
        
        Defaults.synchronize()
    }
    
    static func update(saleObject: SaleViewModel) {

        if let savedArray = Defaults[.sales], savedArray.count > 0 {
            
            let similarSavedObjects = savedArray.filter({ ($0.id == saleObject.id) })

            // if saleObject already exists, remove it, and re-save the version passed as an argument -> effectively updating the model on disk
            if similarSavedObjects.count >= 1 {
 
                self.remove(saleObject: similarSavedObjects.first!)
                
                if var updatedArray = Defaults[.sales], updatedArray.count > 0 {
                    updatedArray.append(saleObject)
                    Defaults[.sales] = updatedArray
                } else {
                  Defaults[.sales] = [saleObject]
                }
                
            }
        }
        
        Defaults.synchronize()
    }
    
    static func allSavedSales() -> [SaleViewModel]? {
        guard let savedArray = Defaults[.sales] else { return nil }
        return savedArray
    }
    
    static func remove(saleObject: SaleViewModel) {
        
        if var savedArray = Defaults[.sales], savedArray.count > 0 {
            savedArray.removeAll(where: { ($0.id == saleObject.id) })
            Defaults[.sales] = savedArray
            Defaults.synchronize()
        }
    }
    
    static func removeAllSales() {
        Defaults[.sales] = nil
        Defaults.synchronize()
    }
}
