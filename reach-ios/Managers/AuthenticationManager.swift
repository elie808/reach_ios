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
    static let salesData = DefaultsKey<[ReportSaleModel]?>("sale-data")
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
    
    static func addToSalesData(dailySale: ReportSaleModel) {

        if var savedArray = Defaults[.salesData], savedArray.count > 0 {
            
            savedArray.append(dailySale)
            Defaults[.salesData] = savedArray
            
        } else {
            
            Defaults[.salesData] = [dailySale]
        }
        
        Defaults.synchronize()
    }

    static func removeSalesObject(saleToRemove: ReportSaleModel) {
        
        if var savedArray = Defaults[.salesData], savedArray.count > 0 {
            
            savedArray.removeAll (where: { saleToRemove.productID == $0.productID })
            
            Defaults[.salesData] = savedArray
            Defaults.synchronize()
        }
    }
    
    static func getAllSavedSales() -> [ReportSaleModel]? {
        guard let savedArray = Defaults[.salesData] else { return nil }
        return savedArray
    }
    
    static func deleteAddSalesData() {
        Defaults[.salesData] = nil
        Defaults.synchronize()
    }
}
