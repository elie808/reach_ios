//
//  User.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/8/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let firstName : String
    let lastName : String
    let mobileNumber : String
    let dob : String
    let email : String
    let gender : String
    let image : String
    
    let totalApprovedPoints : Int
    let maxPoints : Int
    
    let organization : Organization
    
    // when implementing custom key-value mapping
    private enum CodingKeys: String, CodingKey {
        
        case email, gender, image, organization
        case firstName = "first_name"
        case lastName = "last_name"
        case mobileNumber = "mobile_number"
        case dob = "date_of_birth"
        case totalApprovedPoints = "total_approved_points"
        case maxPoints = "max_points"
    }
}

struct Organization : Codable {
    let id : Int
    let name : String
}
