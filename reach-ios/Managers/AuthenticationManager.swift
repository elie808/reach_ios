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
//    static let authenticationData = DefaultsKey<String?>("authentication-data")
//    static let userAreaID = DefaultsKey<String?>("user-area-id")
}

// Add persistence methods here, as needed
final class AuthenticationManager {
    
    static func persistToUserDefaults(authenticationData: AuthenticationData) {
        Defaults[.authenticationData] = authenticationData
        Defaults.synchronize()
    }
   
    static var isAuthenticated: Bool {
        return (Defaults[.authenticationData] == nil) ? false : true
    }
    
    private static func clearUserDefaults() {
        Defaults[.authenticationData] = nil
        Defaults.synchronize()
    }
}

// Extension to support handling AuthenticationData in SwiftyUserDefaults Pod
extension UserDefaults {
    subscript(key: DefaultsKey<AuthenticationData?>) -> AuthenticationData? {
        get { return unarchive(key) }
        set { archive(key, newValue) }
    }
}
