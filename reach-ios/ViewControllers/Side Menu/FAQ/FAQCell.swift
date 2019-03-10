//
//  FAQCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/5/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class FAQCell: GenericTableCell<FAQItem> {
    
    @IBOutlet weak var questionLabel : UILabel!
    @IBOutlet weak var answerTextView : UITextView!
    
    override var model : FAQItem! {
        didSet {
            questionLabel.text = model.question
            answerTextView.attributedText = model.answer.convertHTMLToString(withFormatting: String.formatHTML(size: 14.0, fontColor: .reachGray))
        }
    }
}
