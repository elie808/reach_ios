//
//  AboutViewController.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/5/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var textView : UITextView!
    
    // MARK: - Views Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let terms = Resource<Terms>(get: URL(string:NetworkingConstants.about)!)
        
        URLSession.shared.load(terms) { (termsObj, status) in
            self.textView.attributedText = termsObj?.text.convertHTMLToString(withFormatting: String.formatHTML(size: 14.0))
        }
    }
}
