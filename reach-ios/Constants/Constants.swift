//
//  Constants.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/20/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct Constants {
    static let reachEmail   = "reach@channelpro.co"
    static let pointsEmail  = "points@channelpro.co"
    static let supportEmail = "support@channelpro.co"
}

extension String {
    
    // MARK: - Text Fields Local Error Messages'
    
    static var cantBeEmpty: String {
        return NSLocalizedString("Field cannot be empty", comment: "error message")
    }
    
    static var passwordRequired: String {
        return NSLocalizedString("Password Required", comment: "error message")
    }
    
    static var sixMinimumCharacters: String {
        return NSLocalizedString("Minimum 6 characters", comment: "error message")
    }
    
    static var emailFormatNotValid: String {
        return NSLocalizedString("Email format is not valid", comment: "error message")
    }
}
