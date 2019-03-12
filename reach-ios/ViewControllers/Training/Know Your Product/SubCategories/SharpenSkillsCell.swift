//
//  SharpenSkillsCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/24/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class SharpenSkillsCell: GenericTableCell<SubCategory> {
    
    @IBOutlet weak var cellImageView : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    
    override var model : SubCategory! {
        didSet {
            cellImageView.urlSetImage(model.image)
            titleLabel.text = model.name
            dateLabel.text = model.part_number
            descriptionLabel.text = model.description
        }
    }
}
