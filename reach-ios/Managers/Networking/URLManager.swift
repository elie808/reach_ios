//
//  URLManager.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/14/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import Foundation

struct NetworkingConstants {
    
    private struct Domains {
        static let baseURL = "https://www.premieronline.com/"
    }
    
    private struct Routes {
        static let index = "webservice/checkin/index.php"
        static let sync = "webservice/checkin/sync.php"
        static let about = "event/walkon2018"
    }
    
    static let eventURL = Domains.baseURL + Routes.index
}
