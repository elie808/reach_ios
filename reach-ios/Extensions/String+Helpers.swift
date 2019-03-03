//
//  String+Helpers.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/27/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
 
    func convertHTMLToString() -> NSAttributedString {
        
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        
//        let fontAttribute = [ NSAttributedString.Key.font: UIFont(name: "SF Mono", size: 14.0)]
        
        let htmlData = NSString(string: self).data(using: String.Encoding.unicode.rawValue)
        let attributedString = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
        
        return attributedString
    }
}
