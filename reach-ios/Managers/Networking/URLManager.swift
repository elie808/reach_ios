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
        static let baseURL = "http://18.185.199.168:3000/"
    }
    
    private struct Static {
        static let faq   = "static/faq"
        static let terms = "static/terms"
        static let contact = "static/contact"
        static let about = "static/about"
        static let privacy = "static/privacy"
        static let banners = "static/banners"
    }
    
    private struct Training {
        static let allCategories = "static/trainings/categories/"
    }

    
    static let allCategories = Domains.baseURL + Training.allCategories
}
