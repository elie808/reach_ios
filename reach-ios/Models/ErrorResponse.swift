//
//  ErrorResponse.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/19/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import Foundation

struct ErrorResponse : Codable {
    let code : Int
    let message : String
}
