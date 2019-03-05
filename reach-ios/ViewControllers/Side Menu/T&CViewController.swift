//
//  T&CViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/28/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

struct Terms : Codable {
    let text :  String
}

class T_CViewController: UIViewController {

    @IBOutlet weak var textView : UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let terms = Resource<Terms>(get: URL(string:NetworkingConstants.termsAndConditions)!)
        
        URLSession.shared.load(terms) { (termsObj, status) in
            self.textView.attributedText = termsObj?.text.convertHTMLToString(withFormatting: String.formatHTML(size: 14.0))
        }
        
    }
}
