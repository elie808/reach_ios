//
//  NetworkingManager.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/18/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

enum HttpMethod<Body> {
    case get
    case post(Body)
    case patch(Body)
}

extension HttpMethod {
    
    var method: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .patch: return "PATCH"
        }
    }
}

struct HttpStatus {
    
    var code : Int = 0
    
    enum message {
        case Success
        case Failure
        case Undefined
    }
    
    var status : HttpStatus.message {
        switch self.code {
        case 200...300: return .Success
        default: return .Undefined
        }
    }
}

extension URLSession {
    
    func load<A>(_ resource: Resource<A>, completion: @escaping (A?, HttpStatus) -> ()) {
    
        SVProgressHUD.show()
        
        dataTask(with: resource.urlRequest) { (data, response, error) in
            
            DispatchQueue.main.async {
            
                SVProgressHUD.dismiss()
                
                if let resp : HTTPURLResponse = response as? HTTPURLResponse {

                    #if DEBUG
                    print("--")
                    print("STATUS:")
                    print(resp.statusCode)
                    #endif
                    
                    if resp.statusCode >= 200 && resp.statusCode <= 300 {
                        completion(data.flatMap(resource.parse), HttpStatus(code: resp.statusCode))
                    } else {
                        let errorObj = try? JSONDecoder().decode(ErrorResponse.self, from: data!)
                        print("ERROR Message: ", errorObj?.message as Any)
                    }

                } else {
                    completion(data.flatMap(resource.parse), HttpStatus(code: 0))
                }   
            }
            }.resume()
    }
    
    func upload<A>(_ resource: Resource<A>, completion: @escaping (A?, HttpStatus) -> ()) {

        SVProgressHUD.show()

        dataTask(with: resource.urlRequest as URLRequest) { (data, response, error) in
            
            DispatchQueue.main.async {
             
                SVProgressHUD.dismiss()
                
                if let resp : HTTPURLResponse = response as? HTTPURLResponse {
//                    guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
//                        print ("server error")
//                        return
//                    }
//                    if resp.statusCode == 403 {
//                        let errorObj = try? JSONDecoder().decode(ErrorResponse.self, from: data!)
//                        print("ERROR Message: ", errorObj?.message)
//                    }
                    completion(data.flatMap(resource.parse), HttpStatus(code: resp.statusCode))
                } else {
                    completion(data.flatMap(resource.parse), HttpStatus(code: 0))
                }
            }
        }.resume()
    }
}
