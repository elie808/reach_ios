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
    
    // MARK: - HTML
    
    /// Produce a CSS formatting string to append to any HTML text that needs formatting
    static func formatHTML(size:CGFloat) -> String {
        
        let postFont = UIFont.systemFont(ofSize: size)
        
        // Additional formatting to <p> tag
//        let paragraphStyle = "p{font-family: '\(String(describing: postFont.fontName))'; font-size: \(String(describing: postFont.pointSize)); color : \(String(describing: UIColor.red.toHex!))}"
        
        let body = "body{ font-family:'\(String(describing: postFont.fontName))'; font-size:\(String(describing: postFont.pointSize)); color: \(String(describing: UIColor.reachGray.toHex!)) }"

        let formattingString = "<style>\(body)</style>"
        
        return formattingString
    }
 
    func convertHTMLToString(withFormatting formatting:String? = "") -> NSAttributedString {
        
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        
        let formatedString = formatting! + self

        let htmlData = NSString(string: formatedString).data(using: String.Encoding.unicode.rawValue)
        let attributedString = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
        
        return attributedString
    }
}
