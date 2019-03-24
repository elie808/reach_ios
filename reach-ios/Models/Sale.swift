//
//  ReportSaleModel.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/21/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

// Persisted on device. Handy for editing sale objects
struct SaleViewModel : Codable, DefaultsSerializable {
    var sale : Sale = Sale()
    var product : Product?
    
    var imageData : Data?
    
    var id : Double?
}

// Object used to POST to server
struct Sale : Codable, DefaultsSerializable {
    
    var productID : Int = 0
    var productName : String = ""
    
    var serialNumber : String = ""
    var additionalInfo : String = ""
    
    var image : Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case productName, image
        case serialNumber = "serial_number"
        case additionalInfo = "additional_info"
        case productID = "product_id"
    }
}
