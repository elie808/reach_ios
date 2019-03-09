//
//  AuthenticationData.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/8/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

// Conform to DefaultsSerializable to enable encoding custom types into SwiftyUserDefaults
struct AuthenticationData : Codable, DefaultsSerializable {
    public var token: String?
    public var member: User?
}
