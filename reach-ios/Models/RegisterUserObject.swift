//
//  RegisterUserObject.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/20/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import Foundation

struct RegisterUserObject : Encodable {
    var first_name, last_name, mobile_number, date_of_birth, email, password, gender : String
    var organization, image_id : Int
    var brands : [Int]
    var message : String?
}

extension RegisterUserObject: Decodable {
    
    enum MyStructKeys: String, CodingKey { // declaring our keys
        case first_name, last_name, mobile_number, date_of_birth, email, password, gender, organization, image_id, brands, message
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: MyStructKeys.self) // defining our (keyed) container
        let message : String = try container.decode(String.self, forKey: .message) // extracting the data
        
        self.init(first_name: "", last_name: "", mobile_number: "", date_of_birth: "", email: "", password: "", gender: "", organization: 0, image_id: 0, brands: [],
                  message: message)
    }
}
