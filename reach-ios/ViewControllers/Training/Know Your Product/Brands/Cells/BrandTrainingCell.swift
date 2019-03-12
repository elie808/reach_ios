//
//  BrandTrainingCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/12/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class BrandTrainingCell: GenericTableCell<BrandTraining> {
    
    @IBOutlet weak var cellImageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    
    override var model : BrandTraining! {
        didSet {
            cellImageView.urlSetImage(model.image, #imageLiteral(resourceName: "LoginLogo"))
            nameLabel.text = model.name
        }
    }
}
