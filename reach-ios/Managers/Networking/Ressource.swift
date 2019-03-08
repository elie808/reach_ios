//
//  Ressource.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/1/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import Foundation
import SwiftyUserDefaults
import UIKit

struct Resource<A> {
    var urlRequest: URLRequest
    let parse: (Data) -> A?
}

extension Resource where A: Decodable {
    
    // GET
    init(get url: URL) {
        
        self.urlRequest = URLRequest(url: url)
        
//        if AuthenticationManager.isAuthenticated == true {
        
//            let jwtToken = Defaults[.authenticationData]?.token
//
//            if jwtToken != nil {
//                urlRequest.addValue("Bearer" + " " + jwtToken!, forHTTPHeaderField: "Authorization")
//            }
//        }
        
        self.parse = { data in
            try? JSONDecoder().decode(A.self, from: data)
        }
    }
    
    // POST, PUT, etc.
    init<Body: Encodable>(url: URL, method: HttpMethod<Body>) {
        
        urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpMethod = method.method
        
        switch method {
        case .get: () // do nothing
        case .post(let body): self.urlRequest.httpBody = try! JSONEncoder().encode(body)
        }
        
//        if AuthenticationManager.isAuthenticated == true {
//
//            let jwtToken = Defaults[.authenticationData]?.token
//
//            if jwtToken != nil {
//                self.urlRequest.addValue("Bearer" + " " + jwtToken!, forHTTPHeaderField: "Authorization")
//            }
//        }
        
        self.parse = { data in
            try? JSONDecoder().decode(A.self, from: data)
        }
    }
}

extension Resource {
    
    // transform the returned ressouce. Pick the first struct, or sort or whatever
    // Extending Map. It takes an A, produces a B, and then returns a ressource of B.
    // In this example, we're simply parsing (self.parse) the first object returned
    func map<B>(_ transform: @escaping (A) -> B) -> Resource<B> {
        return Resource<B>(urlRequest: urlRequest) {
            self.parse($0).map(transform) }
    }
}
