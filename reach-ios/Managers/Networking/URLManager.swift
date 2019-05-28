//
//  URLManager.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/14/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import Foundation

struct NetworkingConstants {
    
    // MARK: - Routes
    
    private struct Domains {
        static let ressourceURL = "http://test.channelpro.co"
        static let baseURL      = "http://test.channelpro.co:3000/"
        static let cmsBaseURL   = "http://reach.xtnd.io/cms/www/"
    }

//    private struct Domains {
//        static let ressourceURL = "http://reach.channelpro.co"
//        static let baseURL      = "http://reach.channelpro.co:3000/"
//        static let cmsBaseURL   = "http://reach.xtnd.io/cms/www/"
//    }
    
    private struct Feedback {
        static let feedback = "feedback/"
        static let feedbackSurvey = "feedback/survey/"
    }
    
    private struct News {
        static let allNews = "static/news"
        static let newsDetails = "static/news/"
    }
    
    private struct Organizations {
        static let allOrganizations = "organizations/all"
        static let userOrganizations = "organizations/user"
    }
    
    private struct Promotions {
        static let allPromotions = "promotions/all"
        static let products = "promotions/products"
    }
    
    private struct Sales {
        static let sales = "sales/"
    }
    
    private struct Static {
        static let about = "static/about"
        static let faq   = "static/faq"
        static let terms = "static/terms"
        static let privacy = "static/privacy"
        static let banners = "static/banners"
        static let contact = "static/contact"
        static let imageUpload = "static/image/upload"
    }
    
    private struct Training {
        static let allCategories = "static/trainings/categories/"
    }

    private struct User {
        static let login = "members/login"
        static let profile = "members/profile"
        static let register = "members/register"
        static let oneSignal = "members/onesignal"
    }
    
    private struct ProductTraining {
        static let allVendors = "products/vendors/all/training"
        static let vendorBase = "products/vendors/"
        static let brandBase = "products/brands/"
        static let categoryBase = "products/categories/"
        static let subCategoryBase = "products/subcategories/"
        static let media = "/media"
        static let products = "products/"
        static let training = "/training"
    }
    
    private struct Search {
        static let freeSearch = "products/search/"
        static let serialSearch = "products/search/serial/"
    }
    
    private struct Vendor {
        static let brands = "products/vendors/all/"
    }
    
    // MARK: - URLs
    
    static let baseURL : URL! = URL(string: Domains.baseURL)
    static let ressourcesURL : URL! = URL(string: Domains.ressourceURL)
    static let cmsBaseURL : URL! = URL(string: Domains.cmsBaseURL)
    
    static let about    = Domains.baseURL + Static.about
    static let allCategories = Domains.baseURL + Training.allCategories
    static let allOrganizations = Domains.baseURL + Organizations.allOrganizations
    static let allNews  = Domains.baseURL + News.allNews
    static let allPromotions  = Domains.baseURL + Promotions.allPromotions
    static let banners  = Domains.baseURL + Static.banners
    static let contact  = Domains.baseURL + Static.contact
    static let faqs     = Domains.baseURL + Static.faq
    static let imageUpload = Domains.baseURL + Static.imageUpload
    static let login    = Domains.baseURL + User.login
    static let newsDetails = Domains.baseURL + News.newsDetails
    static let oneSignalID = Domains.baseURL + User.oneSignal
    static let userOrganizations = Domains.baseURL + Organizations.userOrganizations
    static let productsUnderPromotion = Domains.baseURL + Promotions.products
    static let profile  = Domains.baseURL + User.profile
    static let register = Domains.baseURL + User.register
    static let sales    = Domains.baseURL + Sales.sales
    static let termsAndConditions = Domains.baseURL + Static.terms
    static let trainingCategory   = Domains.baseURL + Training.allCategories
    static let userVendorsList    = Domains.baseURL + ProductTraining.allVendors
    
    static func brands(foVendorID id:Int) -> String { return Domains.baseURL + ProductTraining.vendorBase + String(id) }
    static func brandTraining(forBrandID id:Int) -> String { return Domains.baseURL + ProductTraining.brandBase + String(id) + ProductTraining.training }
    static func categoryTraining(forBrandID id:Int) -> String { return Domains.baseURL + ProductTraining.categoryBase + String(id) + ProductTraining.training }
    static func feedbackSurvey(forOrgID id:Int) -> String { return Domains.baseURL + Feedback.feedback + String(id) }
    static func postFeedbackSurvey(forSurveyID id:Int) -> String { return Domains.baseURL + Feedback.feedbackSurvey + String(id) }
    static func mediaTraining(forSubCategory id:Int) -> String { return Domains.baseURL + ProductTraining.products + String(id) + ProductTraining.media }
    static func search(byName searchString:String) -> String { return Domains.baseURL + Search.freeSearch + searchString }
    static func search(bySerial searchString:String) -> String { return Domains.baseURL + Search.serialSearch + searchString }
    static func subCategoryTraining(forCategoryID id:Int) -> String { return Domains.baseURL + ProductTraining.subCategoryBase + String(id) + ProductTraining.training }
    static func vendorBrands(forVendorID id:Int) -> String { return Domains.baseURL + ProductTraining.vendorBase + String(id) + ProductTraining.training }
    static func vendors(forOrganizationID id:Int) -> String { return Domains.baseURL + Vendor.brands + String(id) }
    
    // MARK: - Helpers

    /// Create complete URLs from relative paths, used by image ressources, etc.
    static func getURL(path: String, parameters: [String: String] = [:]) -> URL? {
        return baseURL.appendingPathComponent(path).appendingQueryParameters(parameters)
    }
    
}

extension URL {
    
    func appendingQueryParameters(_ parameters: [String: Any]) -> URL? {
        
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = []
        
        for (key, value) in parameters {
            urlComponents?.queryItems?.append(URLQueryItem(name:key, value: value as? String))
        }
        
        return urlComponents?.url
    }
}
