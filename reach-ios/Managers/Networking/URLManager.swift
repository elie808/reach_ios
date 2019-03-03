//
//  URLManager.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/14/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import Foundation

struct NetworkingConstants {
    
    /// Create complete URLs from relative paths, used by image ressources, etc.
    static func getURL(path: String, parameters: [String: String] = [:]) -> URL? {
        return baseURL.appendingPathComponent(path).appendingQueryParameters(parameters)
    }
    
    private struct Domains {
        static let baseURL = "http://18.185.199.168:3000/"
        static let cmsBaseURL = "http://reach.xtnd.io/cms/www/"
    }
    
    private struct News {
        static let allNews = "static/news"
        static let newsDetails = "static/news/"
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

    static let baseURL : URL! = URL(string: Domains.baseURL)
    static let cmsBaseURL : URL! = URL(string: Domains.cmsBaseURL)
    
    static let allCategories = Domains.baseURL + Training.allCategories
    static let trainingCategory = Domains.baseURL + Training.allCategories
    static let allNews = Domains.baseURL + News.allNews
    static let newsDetails = Domains.baseURL + News.newsDetails
    
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
