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
//    static let authenticationData = DefaultsKey<String?>("authentication-data")
//    static let userAreaID = DefaultsKey<String?>("user-area-id")
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
//        Cache.deleteAllFiles()
    }
    
    private static func clearUserDefaults() {
        Defaults[.authenticationData] = nil
        Defaults.synchronize()
    }
}

final class PersistenceManager {
    
    static func save(saleObject: SaleViewModel) {
        
        if var savedArray = Defaults[.sales], savedArray.count > 0 {
            savedArray.append(saleObject)
            Defaults[.sales] = savedArray
        } else {
            Defaults[.sales] = [saleObject]
        }
        
        Defaults.synchronize()
    }
    
    static func remove(saleObject: SaleViewModel) {
        
        if var savedArray = Defaults[.sales], savedArray.count > 0 {
            savedArray.removeAll(where: { saleObject.product.id == $0.product.id } )
            Defaults[.sales] = savedArray
            Defaults.synchronize()
        }
    }
    
    static func allSavedSales() -> [SaleViewModel]? {
        guard let savedArray = Defaults[.sales] else { return nil }
        return savedArray
    }
    
    static func removeAllSales() {
        Defaults[.sales] = nil
        Defaults.synchronize()
    }
}
