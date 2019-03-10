//
//  PromotionCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/24/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class PromotionCell: GenericCollectionCell<Promotion> {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override var model : Promotion! {
        didSet {
            imageView.urlSetImage(model.image)
            titleLabel.text = model.name
            let cooo = UIColor.white
            subtitleLabel.attributedText = model.description.convertHTMLToString(withFormatting: String.formatHTML(size: 12.0, fontColor: cooo))
        }
    }
}
