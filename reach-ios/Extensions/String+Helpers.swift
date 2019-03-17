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
    
    func isValidDate() -> Bool {
        let dateRegEx = "[0-9]{4}-[0-9]{2}-[0-9]{2}"
        let dateTest = NSPredicate(format: "SELF MATCHES %@", dateRegEx)
        return dateTest.evaluate(with: self)
    }
    
    // MARK: - HTML
    
    /// Produce a CSS formatting string to append to any HTML text that needs formatting
    static func formatHTML(size:CGFloat, fontColor: UIColor) -> String {
        
        let postFont = UIFont.systemFont(ofSize: size)
        
        // Additional formatting to <p> tag
//        let paragraphStyle = "p{font-family: '\(String(describing: postFont.fontName))'; font-size: \(String(describing: postFont.pointSize)); color : \(String(describing: UIColor.red.toHex!))}"
       
        //TODO: FIX toHEX method bug that won't work for .black, .white
        let colorSt = String(describing: UIColor.reachGray.toHex!) //== nil ? String(describing: UIColor.reachGray.toHex!) : String(describing: fontColor.toHex!)
        
        let body = "body{ font-family:'\(String(describing: postFont.fontName))'; font-size:\(String(describing: postFont.pointSize)); color:\(colorSt) }"

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
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension NSAttributedString {
    
    /// Returns height of String, given a width constraint
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
}
