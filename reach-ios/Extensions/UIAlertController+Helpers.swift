//
//  UIAlertController+Helpers.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/20/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    class func createActionSheet(title: String, message : String?, actions:[UIAlertAction]) -> UIAlertController {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        
        for Action in actions {
            alertController.addAction(Action)
        }
        
        return alertController
    }
    
}
