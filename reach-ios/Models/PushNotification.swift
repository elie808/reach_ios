//
//  PushNotification.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/26/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import Foundation

struct PushNotification : Encodable {
    var id : String
    var onesignal_id : String?
}

extension PushNotification: Decodable {
    
    enum MyStructKeys: String, CodingKey {
        case id, onesignal_id
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: MyStructKeys.self) // defining the (keyed) container
        let oneSignalID : String = try container.decode(String.self, forKey: .onesignal_id) // extracting the data
        
        self.init(id: "", onesignal_id: oneSignalID)
    }
}
