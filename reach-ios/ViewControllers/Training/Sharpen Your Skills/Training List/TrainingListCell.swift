//
//  TrainingListCell.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/1/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

class TrainingListCell: GenericCollectionCell<TrainingListItems> {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override var model : TrainingListItems! {
        didSet {
            // image at URL: http://reach.xtnd.io/cms/www/undefined. THis method is appending the BaseURL, so it's http://18.185.199.168:3000/http://reach.xtnd.io/cms/www/undefined. Does not work X-(
            imageView.urlSetImage(model.image, #imageLiteral(resourceName: "TrainingSharpen"))
            titleLabel.text = model.category
        }
    }
}

