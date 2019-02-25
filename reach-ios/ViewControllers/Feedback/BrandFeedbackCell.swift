//
//  BrandFeedbackCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/25/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class BrandFeedbackCell: GenericTableCell<Company> {
    
    @IBOutlet weak var brandImageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    
    override var model : Company! {
        didSet {
            brandImageView?.image = UIImage(named: model.imageName)
            nameLabel?.text = model.name
        }
    }
}
