//
//  AuthenticationManager.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/13/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import Foundation
import SwiftyUserDefaults


// Models --- TODO: MOve out to separate files

struct AuthenticationData {
    public var token: String?
    public var user: User?
}

struct User {
    public var verified: Int?
}

//////

// Extend to support handling AuthenticationData in SwiftyUserDefaults Pod
extension UserDefaults {
    subscript(key: DefaultsKey<AuthenticationData?>) -> AuthenticationData? {
        get { return unarchive(key) }
        set { archive(key, newValue) }
    }
}

// Extending SwiftyUserDefaults Pod | TODO: Add keys here to extend caching
extension DefaultsKeys {
    static let xDeviceID = DefaultsKey<String?>("x-device-id")
    static let authenticationData = DefaultsKey<AuthenticationData?>("authentication-data")
    static let userAreaID = DefaultsKey<String?>("user-area-id")
    static let userAreaName = DefaultsKey<String?>("user-area-name")
}

final class AuthenticationManager {
    
    static var handleAuthenticationUpdateNavigation: () -> () = {}
    static var handleTooManyAttempts: () -> () = {}
    
    // example 1
    static func persistUserArea(areaID: String, areaName: String) {
        Defaults[.userAreaID] = areaID
        Defaults[.userAreaName] = areaName
        Defaults.synchronize()
    }
    
    // example 2
    static func persistToUserDefaults(authenticationData: AuthenticationData) {
        Defaults[.authenticationData] = authenticationData
        Defaults.synchronize()
    }
    
    static var isAuthenticated: Bool {
        return (Defaults[.authenticationData] == nil) ? false : true
    }
    
    static var isVerified: Bool {
        return (Defaults[.authenticationData]?.user?.verified == 0) ? false : true
    }
    
    private static func clearUserDefaults() {
        Defaults[.authenticationData] = nil
        Defaults[.xDeviceID] = nil
        Defaults[.userAreaID] = nil
        Defaults[.userAreaName] = nil
        Defaults.synchronize()
    }
}
