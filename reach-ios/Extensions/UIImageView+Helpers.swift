//
//  UIImageView+Helpers.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/2/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func urlSetImage(_ stringURL: String? ,_ placeholder : UIImage? = nil) {
        
        guard let stringURL = stringURL else {
            self.image = placeholder
            return
        }

        var url : URL! = nil
        
        if stringURL.contains(NetworkingConstants.baseURL.absoluteString) {
            url = URL(string: stringURL)
        } else if stringURL.contains(NetworkingConstants.cmsBaseURL.absoluteString) {
            url = URL(string: stringURL)
        } else if stringURL.contains(NetworkingConstants.ressourcesURL.absoluteString) {
            url = URL(string: stringURL)
        } else {
            url = NetworkingConstants.getURL(path: stringURL)
        }
        
        guard url != nil else {
            self.image = placeholder
            return
        }
        
//        self.kf.indicatorType = .none
        self.kf.setImage(with: url, placeholder: placeholder, options: [.transition(.fade(1.0))])
    }
}
