//
//  NetworkingManager.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/18/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import Foundation
import UIKit

enum HttpMethod<Body> {
    case get
    case post(Body)
}

extension HttpMethod {
    
    var method: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
}

struct HttpStatus {
    
    var code : Int = 0
    
    var message : String {
        switch self.code {
        case 200...300: return "Success"
        default: return "Undefined"
        }
    }
}

extension URLSession {
    
    func load<A>(_ resource: Resource<A>, completion: @escaping (A?, HttpStatus) -> ()) {
        
        dataTask(with: resource.urlRequest) { (data, response, error) in
            
            if let resp : HTTPURLResponse = response as? HTTPURLResponse {
                completion(data.flatMap(resource.parse), HttpStatus(code: resp.statusCode))
            } else {
                completion(data.flatMap(resource.parse), HttpStatus(code: 0))
            }
            
            }.resume()
    }
}

///////

struct Episode: Codable {
    var number: Int
    var title: String
}

struct Collection: Codable {
    var title: String
}

struct PostMan: Codable {
    var url : String
    var tester : String
    var headers : Headers
}

struct Headers: Codable {
    
    var host : String
    var zubara : String
    var accept_encoding : String
    
    // when implementing custom key-value mapping
    private enum CodingKeys: String, CodingKey {
        case host
        case zubara = "x-forwarded-proto"
        case accept_encoding = "accept-encoding"
    }
}

struct Premiere: Codable {
    var url_logo : String
}

