//
//  SharpenSkillsCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 2/24/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class SharpenSkillsCell: GenericTableCell<Skills> {
    
    @IBOutlet weak var cellImageView : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    
    override var model : Skills! {
        didSet {
            cellImageView.image = UIImage(named: model.imageName)
            titleLabel.text = model.title
            dateLabel.text = model.date
            descriptionLabel.text = model.description
        }
    }
}
