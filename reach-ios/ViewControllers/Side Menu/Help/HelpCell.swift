//
//  HelpCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/8/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class HelpCell: GenericCollectionCell<HelpItem> {
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var imageBackgroundView : UIView!
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var textView : UITextView!
    
    override var model : HelpItem! {
        didSet {
            titleLabel.text = model.title
            textView.text = model.description
            imageView.image = model.image
            imageBackgroundView.backgroundColor = model.circleColor
        }
    }
}
